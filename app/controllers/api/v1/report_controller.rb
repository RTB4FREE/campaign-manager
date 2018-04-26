
module Api
	module V1
		class ReportController < ApplicationController
		  
			require 'json';
			#skip_before_action :verify_authenticity_token
			#layout "webchat_layout"
			
			# Called to open ad banner html webview page
			def summary
				#puts "Receiving incoming message webhook."				
				params.each {|k,v| puts "#{k}=#{v}"}
        offset = 0  # assume start/end in UTC        
        #es_host = ELASTICSEARCH_HOST

        timezone = params[:timezone]
        timezone ||= "UTC"
        timestampObj ={}
        filternull = true if params[:filternull]  
        maxSize = params[:maxsize]
        maxSize ||=1000
        
        if startday = params[:startday] and endday = params[:endday] and 
           params[:startday].to_s =~ /^\d{8}$/ and 
           params[:endday].to_s =~ /^\d{8}$/ 
        then
          timestampObj = {
            gte: startday,
            lte: endday,
            format: "basic_date"        #"yyyyMMdd"
          }
        else
          startTime = params[:start].to_i if params[:start] and params[:start].to_s=~/^\d+$/  
          endTime = params[:end].to_i if params[:end] and params[:end].to_s=~/^\d+$/        
          startTime ||= (Time.now.to_i - (3600*24)  + (offset*3600))
          endTime ||= Time.now.to_i
          startTime *= 1000
          endTime *= 1000
          timestampObj = {
            gte: startTime,
            lte: endTime,
            format: "epoch_millis"
          }
        end



        id2domain = {}
        id2adtype = {}
        id2region = {}
        Campaign.all().each do |o| 
          id2domain[ o.id.to_s ] = o.ad_domain if not o.ad_domain.to_s.empty? 
          id2region[ o.id.to_s ] = o.regions 
          bannerCount = o.banners.length if o.banners
          videoCount = o.banner_videos.length if o.banner_videos
          bannerCount ||= 0
          videoCount ||= 0
          if bannerCount > videoCount
            id2adtype[ o.id.to_s ] = "banner"
          elsif bannerCount < videoCount
            id2adtype[ o.id.to_s ] = "video"
          elsif bannerCount>0 and videoCount>0
            id2adtype[ o.id.to_s ] = "both"
          else
            id2adtype[ o.id.to_s ] = "none"
          end
        end
        
        sumObj = {}
              
        ELASTICSEARCH_HOSTS.each do |name,eshost|        
            es = ElasticReport.new(eshost)
            searchObj =  searchClicks("*",timestampObj,timezone,maxSize)
            if resp= es.querySearch(ELASTICSEARCH_CLICKS_INDEX,searchObj) and resp["aggregations"] and resp["aggregations"]["5"]
                 puts "resp: #{resp.to_json}"
                campaign_clicks = resp["aggregations"]["5"]["buckets"]     
            else
              puts "clicks resp: #{resp.inspect}"
            end
    
            searchObj =  searchPixels("*",timestampObj,timezone,maxSize)
            if resp= es.querySearch(ELASTICSEARCH_PIXELS_INDEX,searchObj) and resp["aggregations"] and resp["aggregations"]["5"]
                 puts "resp: #{resp.to_json}"
                campaign_pixels = resp["aggregations"]["5"]["buckets"]     
            else
              puts "pixels resp: #{resp.inspect}"
            end
    
    
            searchObj =  searchWins( "*",timestampObj,timezone,maxSize)
            puts "searchObj: #{searchObj.to_json}"
            if resp= es.querySearch(ELASTICSEARCH_WINS_INDEX,searchObj) and resp["aggregations"] and resp["aggregations"]["5"]
                campaign_wins = resp["aggregations"]["5"]["buckets"]     
                puts "@campaign_wins: #{campaign_wins.to_json}"
            else
              puts "wins resp: #{resp.inspect}"
            end
            searchObj =  searchBids("type:bids",timestampObj,timezone,maxSize)
            if resp= es.querySearch(ELASTICSEARCH_BIDS_INDEX,searchObj) and resp["aggregations"] and resp["aggregations"]["5"]
                 puts "resp: #{resp.to_json}"
                campaign_bids = resp["aggregations"]["5"]["buckets"]     
            else
                puts "bids resp: #{resp.inspect}"
            end
  
        
            campaign_clicks.each do |o|
              day_string = o["key_as_string"]          
              sumObj[day_string] ||= {}                    
              o["4"]["buckets"].each do |bucket|
                campId = bucket["key"]
                sumObj[day_string][campId] ||= campaignAddAttributes(campId,id2domain,id2adtype,id2region)          
                sumObj[day_string][campId][:clicks] += bucket["doc_count"]            
              end if o["4"] and o["4"]["buckets"]
            end if campaign_clicks
            
    
            campaign_pixels.each do |o|
              day_string = o["key_as_string"]          
              sumObj[day_string] ||= {}                    
              o["4"]["buckets"].each do |bucket| 
                campId = bucket["key"]
                sumObj[day_string][campId] ||= campaignAddAttributes(campId,id2domain,id2adtype,id2region)         
                sumObj[day_string][campId][:pixels] += bucket["doc_count"]                      
              end if o["4"] and o["4"]["buckets"]
            end if campaign_pixels
            
    
            campaign_wins.each do |o|
              day_string = o["key_as_string"]          
              sumObj[day_string] ||= {}                    
              o["4"]["buckets"].each do |bucket| 
                campId = bucket["key"]
                sumObj[day_string][campId] ||=campaignAddAttributes(campId,id2domain,id2adtype,id2region)          
                sumObj[day_string][campId][:wins] += bucket["doc_count"]                      
                sumObj[day_string][campId][:spend] += bucket["3"]["value"].to_f/1000     if bucket["3"] and  bucket["3"]["value"]                                  
              end if o["4"] and o["4"]["buckets"]
            end if campaign_wins
    
            campaign_bids.each do |o|
              day_string = o["key_as_string"]          
              sumObj[day_string] ||= {}                    
              o["4"]["buckets"].each do |bucket| 
                campId = bucket["key"]
                sumObj[day_string][campId] ||=campaignAddAttributes(campId,id2domain,id2adtype,id2region)          
                sumObj[day_string][campId][:bids] += bucket["doc_count"]                      
              end if o["4"] and o["4"]["buckets"]
            end if campaign_bids
        
        end  # End eshost
        
        # aggregte by ad_domain        
        if params[:detail].nil?
          newsumObj = {}
          flatAry = []
          sumObj.each do |day,objs|            
            day = Time.parse(day).strftime("%Y-%m-%d")
            adObj = {}            
            objs.each do |campId,o|
                if not adObj[o[:ad_domain]] 
                    adObj[o[:ad_domain]] = o
                else
                    # add numeric fields 
                    [:clicks,:pixels,:wins,:bids,:spend].each { |key|
                        adObj[o[:ad_domain]][key] += o[key]
                    }
                end
            end
            newsumObj[day] = adObj            
            adObj.each do |ad_domain,o|
              o.merge!({:date => day})
              flatAry.push(o) if filternull.nil? or not ad_domain.to_s.empty?
            end
          end
          #sumObj = newsumObj           
          sumObj = flatAry           
        end
        
				render :layout=> false, :text => { daterange: timestampObj, timezone: timezone, summaries: sumObj }.to_json
				return
			end

    def campaignAddAttributes(key,id2domain,id2adtype,id2region)
          retObj = {
            :ad_domain => id2domain[key],  
            :impression_type => id2adtype[key],
            :region => id2region[key],
            :clicks => 0,
            :pixels => 0,
            :wins => 0,
            :spend => 0,
            :bids => 0
          }
    end


    def searchClicks(queryStr,timestampObj,timezone="UTC",maxSize=100)
        {
          query: {
            bool: {
              must: [
                {
                  query_string: {
                    analyze_wildcard: true,
                    query: queryStr
                  }
                },
                {
                  range: {
                    "@timestamp":timestampObj
                  }
                }
              ],
              must_not: []
            }
          },
          size: 0,   
          aggs: {
            "5": {
              date_histogram: {
                field: "@timestamp",
                interval: "1d",
                time_zone: timezone,
                min_doc_count: 1
              },
              aggs: {
                "4": {
                  terms: {
                    field: "ad_id.keyword",
                    size: maxSize,
                    order: {
                      _count: "desc"
                      }
                  },
                }
              }
            }
          }
        }
    end


    def searchPixels(queryStr,timestampObj,timezone="UTC",maxSize=100)
        {
          query: {
            bool: {
              must: [
                {
                  query_string: {
                    analyze_wildcard: true,
                    query: queryStr
                  }
                },
                {
                  range: {
                    "@timestamp": timestampObj
                  }
                }
              ],
              must_not: []
            }
          },
          size: 0,   
          aggs: {
            "5": {
              date_histogram: {
                field: "@timestamp",
                interval: "1d",
                time_zone: timezone,
                min_doc_count: 1
              },
              aggs: {
                "4": {
                  terms: {
                    field: "ad_id.keyword",
                    size: maxSize,
                    order: {
                      _count: "desc"
                      }
                  }
                }
              }
            }
          }
        }
    end


    
    def searchWins(queryStr,timestampObj,timezone="UTC",maxSize=100)
        {
          query: {
            bool: {
              must: [
                {
                  query_string: {
                    analyze_wildcard: true,
                    query: queryStr
                  }
                },
                {
                  range: {
                    "@timestamp": timestampObj
                  }
                }
              ],
              must_not: []
            }
          },
          size: 0,   
          aggs: {
            "5": {
              date_histogram: {
                field: "@timestamp",
                interval: "1d",
                time_zone: timezone,
                min_doc_count: 1
              },
              aggs: {
                "4": {
                  terms: {
                    field: "adId.keyword",
                    size: maxSize,
                    order: {
                      _count: "desc"
                      }
                  },
                  aggs: {
                    "3": {
                      sum: {
                        field: "price"
                      }
                    }
                  }
                }
              }
            }
          }
        }
    end



    def searchBids(queryStr,timestampObj,timezone="UTC",maxSize=100)
        {
          query: {
            bool: {
              must: [
                {
                  query_string: {
                    analyze_wildcard: true,
                    query: queryStr
                  }
                },
                {
                  range: {
                    "@timestamp":timestampObj
                  }
                }
              ],
              must_not: []
            }
          },
          size: 0,   
          aggs: {
            "5": {
              date_histogram: {
                field: "@timestamp",
                interval: "1d",
                time_zone: timezone,
                min_doc_count: 1
              },
              aggs: {
                "4": {
                  terms: {
                    field: "adid.keyword",
                    size: maxSize,
                    order: {
                      _count: "desc"
                      }
                  }
                }
              }
            }
          }
        }
    end





		end
	end
	
end



__END__

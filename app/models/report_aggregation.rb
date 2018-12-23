class ReportAggregation


  def self.campaignPerformance3(startDay=nil,endDay=nil,nextInterval=5*60,historyInterval=10*60,intervalPeriod="5m",timezone="UTC")
    begin
      timer = Time.now  
      aggTargetEs = ElasticReport.new(ELASTICSEARCH_HOSTS["US"])  # Put all aggregated logs here
      if startDay.nil?  
          startDay = aggTargetEs.getLastLogRecord(ELASTICSEARCH_BIDDERLOGS_INDEX_AGGREGATION,"campaign_perf")    
          #raise  "Error getting last log: #{startDay.inspect}. Skip this cycle."  if startDay.class == Hash and startDay["error"]
          #raise "Invalid start day #{startDay.inspect} retrieved as last log record. Skip this update cycle." if startDay.to_i < (Time.now.to_i - 30*24*3600)
          startDay =  (Time.now.to_i - 30*24*3600)
      end
      if endDay.nil?        
        endDay = Time.now.to_i
      end 
      # Round start time to intervalPeriod edge
      startDay = (startDay.to_f / (5*60)).to_i * 5*60
      # convert to millisecs    
      startDay *= 1000
      endDay *= 1000    
      nextInterval *= 1000
      historyInterval *= 1000
      raise "Invalid start/end.  Start time #{startDay} is after end time #{endDay}." if startDay.to_i>endDay.to_i
      #    
      startTime = startDay
      endTime = startDay 
      creativeSizes = {} # :banners => {}, :videos => {} }      # Create hash map to store creatives size for each id
      Banner.all.each{ |b| 
        if cid = b.campaign_id.to_s
          creativeSizes[cid] ||= { :banner => {}, :video => {} }
          creativeSizes[cid][:banner][b.id.to_s] ||= {}
          creativeSizes[cid][:banner][b.id.to_s][:height] = b.height if b.height 
          creativeSizes[cid][:banner][b.id.to_s][:width] = b.width if b.width 
          creativeSizes[cid][:banner][b.id.to_s][:width_range] = b.width_range if b.width_range 
          creativeSizes[cid][:banner][b.id.to_s][:height_range] = b.height_range if b.height_range 
          creativeSizes[cid][:banner][b.id.to_s][:width_height_list] = b.width_height_list if b.width_height_list
        end
      }
      BannerVideo.all.each{ |b| 
        if cid = b.campaign_id.to_s
          creativeSizes[cid] ||= { :banner => {}, :video => {} }
          creativeSizes[cid][:video][b.id.to_s] ||= {}
          creativeSizes[cid][:video][b.id.to_s][:height] = b.vast_video_height if b.vast_video_height 
          creativeSizes[cid][:video][b.id.to_s][:width] = b.vast_video_width if b.vast_video_width 
          creativeSizes[cid][:video][b.id.to_s][:width_range] = b.width_range if b.width_range 
          creativeSizes[cid][:video][b.id.to_s][:height_range] = b.height_range if b.height_range 
          creativeSizes[cid][:video][b.id.to_s][:width_height_list] = b.width_height_list if b.width_height_list     
        end
      }        
      loop do     
        endTime += nextInterval  # TEST, 5 minutes ago        
        startTime = endTime - historyInterval      
        
   
        ELASTICSEARCH_HOSTS.each do |region,eshost|
            puts "Processing region #{region}"
            # Get last agg time from index query. Set as start time
            if es = ElasticReport.new(eshost)
               campaignPerf= {
                    bids: {},
                    wins: {},                  
                    pixels: {},
                    clicks: {},
                    cost: {}
                }      
                bidsIndex = ELASTICSEARCH_BIDS_INDEX
                winsIndex = ELASTICSEARCH_WINS_INDEX
                pixelsIndex = ELASTICSEARCH_PIXELS_INDEX
                clicksIndex = ELASTICSEARCH_CLICKS_INDEX
                searchObj =  searchWins2( "type:wins",startTime,endTime,intervalPeriod,timezone)
                 puts "wins index #{winsIndex}, ES host #{eshost}, searchObj:\n #{searchObj.to_json}"
                if resp= es.querySearch(winsIndex,searchObj) and resp["aggregations"] and resp["aggregations"]["campaignagg"] 
                    campaignPerf[:wins] = resp["aggregations"]["campaignagg"]["buckets"]     
                    puts "@campaign_wins: #{campaignPerf[:wins]}"
                else
                    puts "resp is #{resp.inspect}"
                end
                
                searchObj =  searchBids2("type:bids",startTime,endTime,intervalPeriod,timezone)
                puts "bids index #{bidsIndex}, ES host #{eshost}, searchObj:\n #{searchObj.to_json}"
                if resp= es.querySearch(bidsIndex,searchObj) and resp["aggregations"] and resp["aggregations"]["campaignagg"]
                    campaignPerf[:bids] = resp["aggregations"]["campaignagg"]["buckets"]
                    puts "@campaign_bids: #{campaignPerf[:bids]}"
                else
                    puts "resp is #{resp.inspect}"
                end
                searchObj =  searchPixels2("type:pixels",startTime,endTime,intervalPeriod,timezone)
                if resp= es.querySearch(pixelsIndex,searchObj) and resp["aggregations"] and resp["aggregations"]["campaignagg"]
                    campaignPerf[:pixels] = resp["aggregations"]["campaignagg"]["buckets"] 
                    puts "@campaign_pixels: #{campaignPerf[:pixels]}"
                end
                searchObj =  searchPixels2("type:clicks",startTime,endTime,intervalPeriod,timezone)
                if resp= es.querySearch(clicksIndex,searchObj) and resp["aggregations"] and resp["aggregations"]["campaignagg"]
                    campaignPerf[:clicks] = resp["aggregations"]["campaignagg"]["buckets"]     
                    puts "@campaign_clicks: #{campaignPerf[:clicks]}"
                end
                Campaign.all.each do |camp|
                    aggClicksObj = campaignPerf[:clicks].find{|b| b["key"].to_s.eql?(camp.id.to_s) } if not campaignPerf[:clicks].nil?                      
                    aggPixelsObj = campaignPerf[:pixels].find{|b| b["key"].to_s.eql?(camp.id.to_s) } if not campaignPerf[:pixels].nil?                      
                    aggBidsObj = campaignPerf[:bids].find{|b| b["key"].to_s.eql?(camp.id.to_s) } if not campaignPerf[:bids].nil?                      
                    aggWinsObj = campaignPerf[:wins].find{|b| b["key"].to_s.eql?(camp.id.to_s) } if not campaignPerf[:wins].nil?   
                    next if not aggClicksObj and not aggPixelsObj and not aggBidsObj and not aggWinsObj 
                    aggClicksObj ||= { "doc_count"=>0}
                    aggBidsObj ||= {"doc_count"=>0}
                    aggWinsObj ||= {"creativeagg"=>{},"doc_count"=>0}
                    aggPixelsObj ||= {"doc_count"=>0}
        
                    # Iterate buckets for interval record
                    aggLogObjBase = {
                         campaignId: camp.id,
                         #campaignName: camp.name,
                         region: region,
                         interval: intervalPeriod
                    }            
                    logRecord = {}
                    # Aggregate bids to 
                    aggBidsObj["creativeagg"]["buckets"].each do |creative_bucket| 
                        creative_bucket["exchangeagg"]["buckets"].each do |exchange_bucket|
                            exchange_bucket["adtypeagg"]["buckets"].each do |adtype_bucket|
                                adtype_bucket["timeagg"]["buckets"].each do |time_bucket|                  
                                    id = "#{camp.id}_#{creative_bucket["key"]}_#{exchange_bucket["key"]}_#{intervalPeriod}_#{time_bucket["key_as_string"]}_#{adtype_bucket["key"]}"
                                    logRecord[id] ||= aggLogObjBase.merge({
                                        creative_id: creative_bucket["key"].to_i,
                                        exchange: exchange_bucket["key"],
                                        timestamp: time_bucket["key"].to_i
                                    })
                                    logRecord[id].merge!( { adtype: adtype_bucket["key"] } ) 
                                    if sizeObj=getCreativeSizeObj(creativeSizes, camp.id.to_s, creative_bucket["key"].to_s, adtype_bucket["key"])                                      
                                        logRecord[id].merge!( { adsize: sizeObj } )
                                    end
                                    logRecord[id].merge!( { bids: time_bucket["doc_count"] } )
                                end if adtype_bucket["timeagg"] and adtype_bucket["timeagg"]["buckets"]
                            end if exchange_bucket["adtypeagg"] and exchange_bucket["adtypeagg"]["buckets"]
                        end if creative_bucket["exchangeagg"] and creative_bucket["exchangeagg"]["buckets"]  
                    end if aggBidsObj["creativeagg"] and aggBidsObj["creativeagg"]["buckets"]  
                    aggWinsObj["creativeagg"]["buckets"].each do |creative_bucket| 
                        creative_bucket["exchangeagg"]["buckets"].each do |exchange_bucket|
                            exchange_bucket["adtypeagg"]["buckets"].each do |adtype_bucket|
                                adtype_bucket["timeagg"]["buckets"].each do |time_bucket|
                                    id = "#{camp.id}_#{creative_bucket["key"]}_#{exchange_bucket["key"]}_#{intervalPeriod}_#{time_bucket["key_as_string"]}_#{adtype_bucket["key"]}"
                                    logRecord[id] ||= aggLogObjBase.merge({
                                        creative_id: creative_bucket["key"].to_i,
                                        exchange: exchange_bucket["key"],
                                        timestamp: time_bucket["key"].to_i
                                    })                                                                    
                                    logRecord[id].merge!( { adtype: adtype_bucket["key"] } )  # adtype is only in win/bid record                                  
                                    if sizeObj=getCreativeSizeObj(creativeSizes, camp.id.to_s, creative_bucket["key"].to_s, adtype_bucket["key"])
                                        logRecord[id].merge!( { adsize: sizeObj } )
                                    end
                                    logRecord[id].merge!( { wins: time_bucket["doc_count"] } )
                                    if time_bucket["priceagg"] and wincost = time_bucket["priceagg"]["value"]
                                      # Get creative object
                                      logRecord[id].merge!( { cost: wincost } )
                                    end
                                end if adtype_bucket["timeagg"] and adtype_bucket["timeagg"]["buckets"]
                            end if exchange_bucket["adtypeagg"] and exchange_bucket["adtypeagg"]["buckets"]
                        end if creative_bucket["exchangeagg"] and creative_bucket["exchangeagg"]["buckets"]  
                    end if aggWinsObj["creativeagg"] and aggWinsObj["creativeagg"]["buckets"]
    
                     aggPixelsObj["creativeagg"]["buckets"].each do |creative_bucket| 
                        creative_bucket["exchangeagg"]["buckets"].each do |exchange_bucket|
                            exchange_bucket["timeagg"]["buckets"].each do |time_bucket|                                                  
                                adtype = nil
                                if sizeObj=getCreativeSizeObj(creativeSizes, camp.id.to_s, creative_bucket["key"].to_s, nil)
                                    adtype = sizeObj[:adtype]
                                end
                                id = "#{camp.id}_#{creative_bucket["key"]}_#{exchange_bucket["key"]}_#{intervalPeriod}_#{time_bucket["key_as_string"]}_#{adtype}"                              
                                logRecord[id] ||= aggLogObjBase.merge({
                                    creative_id: creative_bucket["key"].to_i,
                                    exchange: exchange_bucket["key"],
                                    timestamp: time_bucket["key"].to_i
                                })
                                logRecord[id].merge!( { pixels: time_bucket["doc_count"] } )
                            end if exchange_bucket["timeagg"] and exchange_bucket["timeagg"]["buckets"]
                        end if creative_bucket["exchangeagg"] and creative_bucket["exchangeagg"]["buckets"]  
                    end if aggPixelsObj["creativeagg"] and aggPixelsObj["creativeagg"]["buckets"]  
                    
                     aggClicksObj["creativeagg"]["buckets"].each do |creative_bucket| 
                        creative_bucket["exchangeagg"]["buckets"].each do |exchange_bucket|
                            exchange_bucket["timeagg"]["buckets"].each do |time_bucket|                    
                                adtype = nil
                                if sizeObj=getCreativeSizeObj(creativeSizes, camp.id.to_s, creative_bucket["key"].to_s, nil)
                                    adtype = sizeObj[:adtype]
                                end
                                id = "#{camp.id}_#{creative_bucket["key"]}_#{exchange_bucket["key"]}_#{intervalPeriod}_#{time_bucket["key_as_string"]}_#{adtype}"                              
                                logRecord[id] ||= aggLogObjBase.merge({
                                    creative_id: creative_bucket["key"].to_i,
                                    exchange: exchange_bucket["key"],
                                    timestamp: time_bucket["key"].to_i
                                })
                                logRecord[id].merge!( { clicks: time_bucket["doc_count"] } )
                            end if exchange_bucket["timeagg"] and exchange_bucket["timeagg"]["buckets"]
                        end if creative_bucket["exchangeagg"] and creative_bucket["exchangeagg"]["buckets"]  
                    end if aggClicksObj["creativeagg"] and aggClicksObj["creativeagg"]["buckets"]    
  
                    logRecord.each do |k,v|
                      #111_5m_2017-06-02T15:15:00.000Z
                      #Timezone in query must be utc
                      if k.to_s=~/_#{intervalPeriod}_(\d\d\d\d)-(\d\d)-(\d\d)T/
                        year=$1
                        month=$2
                        day=$3
                        puts "Log record for index bidagg-#{year}.#{month}.#{day}, id #{k}: "+v.to_json
                        aggTargetEs.indexLogRecord("bidagg-#{year}.#{month}.#{day}","campaign_perf",k,v)
                      end
                    end
                end
            end
        end
        puts "Report interval time #{Time.at(startTime/1000).to_s} to #{Time.at(endTime/1000).to_s} "
        break if startTime >= endDay  
      end            
      puts "Elapsed time #{Time.now.to_i - timer.to_i} secs"
    rescue Exception => e  
      puts e.message  
    end
  end

    def self.searchWins2(queryStr,startTime,endTime,intervalPeriod,timezone,maxSize=10000)
        {
          "query": {
           "bool": {
              "must": [
                {
                  "query_string": {
                    "analyze_wildcard": true,
                    "query": queryStr
                  }
                },
                {
                  "range": {
                    "@timestamp": {
                      "gte": startTime,
                      "lte": endTime,
                      "format": "epoch_millis"
                    }
                  }
                }
              ],
              "must_not": []
            }
          },
          "size": 0,    
          "aggs": {
            "campaignagg": {
              "terms": {
                "field": "adId.keyword",
                "size": maxSize,
                "order": {
                  "_count": "desc"
                }
              },
              "aggs": {
                "creativeagg": {
                  "terms": {
                    "field": "cridId.keyword",
                    "size": maxSize,
                    "order": {
                      "_count": "desc"
                    }
                  },
                  "aggs": {
                    "exchangeagg": {
                      "terms": {
                        "field": "pubId.keyword",
                        "size": maxSize,
                        "order": {
                          "_count": "desc"
                        }
                      },
                      "aggs":{
                        "adtypeagg":{
                          "terms": {
                            "field": "adtype.keyword",
                            "size": maxSize,
                            "missing": "none"
                          },
                        "aggs": {
                            "timeagg": {
                              "date_histogram": {
                                "field": "@timestamp",
                                "interval": intervalPeriod,
                                "time_zone": timezone,
                                "min_doc_count": 1
                              },
                              "aggs": {
                                "priceagg": {
                                  "sum": {
                                    "field": "price"
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
    end

    def self.searchBids2(queryStr,startTime,endTime,intervalPeriod,timezone,maxSize=1000)
        {
          "query": {
           "bool": {
              "must": [
                {
                  "query_string": {
                    "analyze_wildcard": true,
                    "query": queryStr
                  }
                },
                {
                  "range": {
                    "@timestamp": {
                      "gte": startTime,
                      "lte": endTime,
                      "format": "epoch_millis"
                    }
                  }
                }
              ],
              "must_not": []
            }
          },
          "size": 0,
          "aggs": {
            "campaignagg": {
              "terms": {
                "field": "adid.keyword",
                "size": maxSize,
                "order": {
                  "_count": "desc"
                }
              },
              "aggs": {
                "creativeagg": {
                  "terms": {
                    "field": "crid.keyword",
                    "size": maxSize,
                    "order": {
                      "_count": "desc"
                    }
                  },
                  "aggs": {
                    "exchangeagg": {
                      "terms": {
                        "field": "exchange.keyword",
                        "size":maxSize,
                        "order": {
                          "_count": "desc"
                        }
                      },
                      "aggs":{
                        "adtypeagg":{
                          "terms": {
                            "field": "adtype.keyword",
                            "size": maxSize
                          },                      
                          "aggs": {
                            "timeagg": {
                              "date_histogram": {
                                "field": "@timestamp",
                                "interval": intervalPeriod,
                                "time_zone": timezone,
                                "min_doc_count": 1
                              }                        
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
    end

    def self.searchPixels2(queryStr,startTime,endTime,intervalPeriod,timezone,maxSize=10000)
        {
          "query": {
            "bool": {
              "must": [
                {
                  "query_string": {
                    "analyze_wildcard": true,
                    "query": queryStr
                  }
                },
                {
                  "range": {
                    "@timestamp": {
                      "gte": startTime,
                      "lte": endTime,
                      "format": "epoch_millis"
                    }
                  }
                }
              ],
              "must_not": []
            }
          },
          "size": 0,
          "aggs": {
            "campaignagg": {
              "terms": {
                "field": "ad_id.keyword",
                "size": maxSize,
                "order": {
                  "_count": "desc"
                }
              },
              "aggs": {
                "creativeagg": {
                  "terms": {
                    "field": "creative_id.keyword",
                    "size": maxSize,
                    "order": {
                      "_count": "desc"
                    }
                  },
                  "aggs": {
                    "exchangeagg": {
                      "terms": {
                        "field": "exchange.keyword",
                        "size":maxSize,
                        "order": {
                          "_count": "desc"
                        }
                      },
                      "aggs": {
                        "timeagg": {
                          "date_histogram": {
                            "field": "@timestamp",
                            "interval": intervalPeriod,
                            "time_zone": timezone,
                            "min_doc_count": 1
                          }                      
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
    end


  ELASTICSEARCH_HOST_AGGREGATION = ELASTICSEARCH_HOSTS["US"]
  ELASTICSEARCH_BIDDERLOGS_INDEX_AGGREGATION = "bidagg-*"
  def self.campaignTableSpendUpdate(startTime=nil,endTime=nil)
    begin
      timer = Time.now  
      startTime = 0 if startTime.nil?  
      endTime = Time.now.to_i if endTime.nil?        
      startTime *= 1000
      endTime *= 1000    
      raise "Invalid start/end.  Start time #{startTime} is after end time #{endTime}." if startTime.to_i>endTime.to_i
  #  Get agg object for all campaigns
      es = ElasticReport.new(ELASTICSEARCH_HOST_AGGREGATION)
      queryStr = "*"
      searchObj = campaignPerformanceAgg(queryStr,startTime,endTime)    
      if resp= es.querySearch(ELASTICSEARCH_BIDDERLOGS_INDEX_AGGREGATION,searchObj) and 
          resp["aggregations"] and resp["aggregations"]["7"] and 
          campaignPerf = resp["aggregations"]["7"]["buckets"]     
      then    
          #puts "campaignPerf: #{campaignPerf.to_json}"
          # Make a hash map
          campPerfHash = {}
          campaignPerf.each{|c| campPerfHash[c["key"].to_s] = c }
          #str = (Time.now - (60*60)).strftime("%Y-%m-%d %H:%M:%S")  # in case recently changed to offline
          puts "Hourly budget cycle #{(Time.now.to_i / 300) % 12}"
          update_budget_hourly =  (Time.now.to_i / 300) % 12 == 0 ? true : false
          puts "Daily budget cycle #{(Time.now.to_i / 300) % (12*24)}"
          update_budget_daily =  ((Time.now.to_i / 300) % (12*24)) == 0  ? true : false
          #Campaign.where("(status=\"runnable\") or (status=\"offline\" and updated_at>\"#{str}\")").each do |camp|
          Campaign.where(status:"runnable").each do |camp|
            #stats = campaign.getStatsAgg()
            if stat = campPerfHash[camp.id.to_s]
                updateHash = {}
                updateHash.merge!({ bids: stat["1"]["value"].to_i}) if stat["1"] and stat["1"]["value"] 
                updateHash.merge!({ wins: stat["2"]["value"].to_i}) if stat["2"] and stat["2"]["value"] 
                updateHash.merge!({ pixels: stat["3"]["value"].to_i}) if stat["3"] and stat["3"]["value"] 
                updateHash.merge!({ clicks: stat["4"]["value"].to_i}) if stat["4"] and stat["4"]["value"] 
                updateHash.merge!({ cost: stat["5"]["value"].to_f}) if stat["5"] and stat["5"]["value"] 
                # Carry forward budget, do every hour. Assumes this executes every 5 minutes
                if update_budget_hourly
                  if camp.status.eql?("runnable") and 
                    (camp.spend_rate.to_s.eql?("even") or camp.spend_rate.to_s.eql?("custom")) and 
                    camp.total_budget and 
                    #(true or camp.budget_carry_forward) and 
                    camp.budget_carry_forward and 
                    stat["5"] and stat["5"]["value"] and current_cost=stat["5"]["value"].to_f and
                    camp.expire_time.to_i > camp.activate_time.to_i and
                    Time.now.to_i > camp.activate_time.to_i and Time.now.to_i < camp.expire_time.to_i
                  then              
                    # Assume original budgets are not changed
                    current_cost /= 1000
                    remaining_budget = camp.total_budget - current_cost
                    total_secs = camp.expire_time.to_i - camp.activate_time.to_i
                    if utcWeekJson = camp.day_parting_utc and not utcWeekJson.to_s.empty?
                      remaining_secs = Campaign.getRemainingTimeSecs(JSON.parse(utcWeekJson),camp.expire_time.to_i,camp.activate_time.to_i)
                    else
                      remaining_secs = camp.expire_time.to_i - Time.now.to_i  
                    end
                    #expected_cost = total_budget * remaining_secs/total_seconds              
                    if camp.budget_limit_hourly and remaining_secs>0
                      total_hours = (total_secs / 3600).to_i
                      remaining_hours = (remaining_secs / 3600).to_i + 1    # 3600 = 60*60                
                      expected_cost = camp.budget_limit_hourly * (total_hours - remaining_hours)
                      if expected_cost > current_cost and remaining_hours>0  # under budget so adjust 
                        msg = "Hourly Carry forward budget update for #{camp.id}: budget: #{camp.total_budget}, expected hourly cost #{expected_cost}, current_cost: #{current_cost} "
                        puts msg
                        #new_budget_limit_hourly = remaining_budget / remaining_hours                
                        new_budget_limit_hourly = camp.budget_limit_hourly + (expected_cost - current_cost)/remaining_hours  # Add remainder to the hour budget                
                        msg = "#{camp.id} Hourly change (remaining hours #{remaining_hours}) from #{camp.budget_limit_hourly} to #{new_budget_limit_hourly}"
                        puts msg
                        updateHash.merge!(budget_limit_hourly: new_budget_limit_hourly)
                      else
                        msg = "Hourly Carry forward budget - No update for #{camp.id},  expected hourly cost #{expected_cost} less than current_cost: #{current_cost}"
                        puts msg
                      end
                    end
                    # Check day carryover
                    if update_budget_daily and camp.budget_limit_daily                 
                      total_days = (total_secs / 86400).to_i
                      remaining_days = (remaining_secs / 86400).to_i + 1    # 86400 = 24*60*60
                      expected_cost = camp.budget_limit_daily * (total_days - remaining_days)
                      if expected_cost > current_cost           
                        #budget_limit_daily = remaining_budget / remaining_days  
                        msg = "Daily Carry forward budget update for #{camp.id}: budget: #{camp.total_budget}, expected daily cost #{expected_cost}, current_cost: #{current_cost} "
                        puts msg
                        new_budget_limit_daily = camp.budget_limit_daily + (expected_cost - current_cost)/remaining_days  # Add remainder to the day budget
                        msg =  "#{camp.id} Daily change (remaining days #{remaining_days}) from #{camp.budget_limit_daily} to #{new_budget_limit_daily}"
                        puts msg
                        updateHash.merge!(budget_limit_daily: new_budget_limit_daily)
                      else
                        msg = "Daily Carry forward budget - No update for #{camp.id},  expected daily cost #{expected_cost} less than current_cost: #{current_cost} "
                        puts msg
                      end
                    end
                  else 
                    msg =  "Skip budget carryover processing for campaign #{camp.id}."
                    puts msg
                  end
                else
                  #msg = "Skip hourly budget cycle #{(Time.now.to_i / 300) % 12}"
                  #puts msg
                end
                if updateHash.empty?
                  #msg = "No update for campaign #{camp.id.to_s}."
                else
                  #msg = "Updating campaign #{camp.id.to_s}: #{updateHash}"
                  camp.update(updateHash)
                end
            end
          end  
      end
      puts "Elapsed time #{Time.now.to_i - timer.to_i} secs"
    rescue Exception => e  
      puts e.message  
    end
  end

  def self.getCreativeSizeObj(creativeSizes, campaignId, creativeId, adtype=nil)
    sizeObj = nil
    creativeSizes ||= {}
    campaignId = campaignId.to_s
    creativeId = creativeId.to_s
    sizeObj = nil
    campSizeObj = nil
    if campSizes = creativeSizes[campaignId] 
      if not adtype or adtype.to_s.eql?("unknown")
        if campSizeObj = campSizes[:banner] and sizeObj = campSizeObj[creativeId]   # if adtype is defined
          adtype = :banner
        elsif campSizeObj = campSizes[:video] and sizeObj = campSizeObj[creativeId]   # if adtype is defined
          adtype = :video 
        end
      elsif campSizeObj = campSizes[adtype.to_sym]
        sizeObj = campSizeObj[creativeId]
      else
        puts "campaign #{campaignId} creative #{creativeId} adtype not found: #{adtype.inspect}"
      end
    else
      puts "campaign #{campaignId.inspect}, no creative size found"
    end
    sizeObj.merge!({adtype: adtype}) if sizeObj
    sizeObj
  end
 
    def self.campaignPerformanceAgg(queryStr,startTime,endTime,maxSize=10000)
      {
        "query": {
          "bool": {
            "must": [
              {
                "query_string": {
                  "query": queryStr,
                  "analyze_wildcard": true
                }
              },
              {
                "range": {
                  "timestamp": {
                    "gte": startTime,
                    "lte": endTime,
                    "format": "epoch_millis"
                  }
                }
              }
            ],
            "must_not": []
          }
        },
        "size": 0,
        "_source": {
          "excludes": []
        },
        "aggs": {
          "7": {
            "terms": {
              "field": "campaignId",
              "size": maxSize,
              "order": {
                "1": "desc"
              }
            },
            "aggs": {
              "1": {
                "sum": {
                  "field": "bids"
                }
              },
              "2": {
                "sum": {
                  "field": "wins"
                }
              },
              "3": {
                "sum": {
                  "field": "pixels"
                }
              },
              "4": {
                "sum": {
                  "field": "clicks"
                }
              },
              "5": {
                "sum": {
                  "field": "cost"
                }
              }
            }
          }
        }
      }
    end    

end



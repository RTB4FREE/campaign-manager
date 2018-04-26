class DashboardsController < ApplicationController


  before_filter :authorize

  def home

    offset = BIDDER_TIME_OFFSET  # Adjustment for differnt bidder time 
    @campaign_wins = {}
    @campaign_bids = {}
    @campaign_pixels = {}
    @campaign_clicks = {}
    @timeframes = {}
    @bidder_status ||= {}
    @refresh = false
    if params[:refresh] 
      @refresh = true
      @timeframes = {
          :last_hour => Time.now.to_i - 3600 + (offset*3600),
          :last_8_hours =>  Time.now.to_i - (3600*8)  + (offset*3600),
          :last_24_hours =>  Time.now.to_i - (3600*24)  + (offset*3600),    
          :all_history =>  0
      }
      @timeframe_col_labels = ["1hr","8hr","24hr","All"]
      
      ELASTICSEARCH_HOSTS.each do |name,eshost|
          @campaign_wins[name] = {}
          @campaign_bids[name] = {}
          @campaign_pixels[name] = {}
          @campaign_clicks[name] = {}
          @bidder_status[name] = {}
          es = ElasticReport.new(eshost)
          @timeframes.each do |timelabel,startTime|
              endTime = Time.now.to_i * 1000
              startTime *= 1000
              searchObj =  searchWins( "*",startTime,endTime)
              if resp= es.querySearch(ELASTICSEARCH_WINS_INDEX,searchObj) and resp["aggregations"] and resp["aggregations"]["4"]
                  @campaign_wins[name][timelabel] = resp["aggregations"]["4"]["buckets"]     
              end
              searchObj =  searchBids("*",startTime,endTime)
              if resp= es.querySearch(ELASTICSEARCH_BIDS_INDEX,searchObj) and resp["aggregations"] and resp["aggregations"]["4"]
                  @campaign_bids[name][timelabel] = resp["aggregations"]["4"]["buckets"]     
              end
              searchObj =  searchPixels("*",startTime,endTime)
              if resp= es.querySearch(ELASTICSEARCH_PIXELS_INDEX,searchObj) and resp["aggregations"] and resp["aggregations"]["4"]
                  @campaign_pixels[name][timelabel] = resp["aggregations"]["4"]["buckets"]     
              end
              searchObj =  searchPixels("*",startTime,endTime)
              if resp= es.querySearch(ELASTICSEARCH_CLICKS_INDEX,searchObj) and resp["aggregations"] and resp["aggregations"]["4"]
                  @campaign_clicks[name][timelabel] = resp["aggregations"]["4"]["buckets"]     
              end

               @campaign_wins[name][timelabel] ||= []
               @campaign_bids[name][timelabel] ||= []
               @campaign_pixels[name][timelabel] ||= []
               @campaign_clicks[name][timelabel] ||= []
          end

         # Get bidder status for last hour
          endTime = Time.now.to_i * 1000
          startTime = (Time.now.to_i - 3600 + (offset*3600)) * 1000    
          searchObj = bidderStatus("*",startTime,endTime)
          if resp = es.querySearch(ELASTICSEARCH_STATS_INDEX,searchObj) and resp["aggregations"] and resp["aggregations"]["4"]
              puts "status response: #{resp.to_json}"
              @bidder_status[name] = resp["aggregations"]["4"]["buckets"]  
          end
          
      end
    end    
  end


  def campaigndetail
    @campaign = Campaign.find(params[:id])  
    es = ElasticReport.new(ELASTICSEARCH_HOST)
    offset = BIDDER_TIME_OFFSET
    endTime = Time.now.to_i * 1000
    startTime = Time.now.to_i - (3600*24)  + (offset*3600)
    startTime *=  1000
    searchObj =  graphCounts( "*",startTime,endTime,"1h",RTB_REPORT_TIMEZONE)
    Rails.logger.info("wins searchObj: #{searchObj.to_json}")
    if resp= es.querySearch(ELASTICSEARCH_WINS_INDEX,searchObj) and resp["aggregations"] and resp["aggregations"]["2"]
        Rails.logger.info("wins resp: #{resp.to_json}")
        @campaign_wins = resp["aggregations"]["2"]["buckets"]    
    else
      Rails.logger.info("wins bad resp: #{resp.to_json}")
    end 
    searchObj =  graphCounts( "*",startTime,endTime,"1h",RTB_REPORT_TIMEZONE)
    Rails.logger.info("bids searchObj: #{searchObj.to_json}")
    if resp= es.querySearch(ELASTICSEARCH_BIDS_INDEX,searchObj) and resp["aggregations"] and resp["aggregations"]["2"]
        Rails.logger.info("bids resp: #{resp.to_json}")
        @campaign_bids = resp["aggregations"]["2"]["buckets"]    
    else 
      Rails.logger.info("bids bad resp: #{resp.to_json}")
    end    
    
    searchObj =  graphWinPrice( "*",startTime,endTime,"1h",RTB_REPORT_TIMEZONE)
    Rails.logger.info("winsprice searchObj: #{searchObj.to_json}")
    if resp= es.querySearch(ELASTICSEARCH_WINS_INDEX,searchObj) and resp["aggregations"] and resp["aggregations"]["2"]
        Rails.logger.info("winsprice resp: #{resp.to_json}")
        @campaign_winsprice = resp["aggregations"]["2"]["buckets"] 
    else 
       Rails.logger.info("winsprice bad resp: #{resp.to_json}")
    end        
    
    
  end


    private

    def searchPixels(queryStr,startTime,endTime,maxSize=100)
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
                    "@timestamp": {
                      gte: startTime,
                      lte: endTime,
                      format: "epoch_millis"
                    }
                  }
                }
              ],
              must_not: []
            }
          },
          size: 0,   
          aggs: {
            "4": {
              terms: {
                field: "ad_id.keyword",
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
    end

    
    def searchWins(queryStr,startTime,endTime,maxSize=100)
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
                    "@timestamp": {
                      gte: startTime,
                      lte: endTime,
                      format: "epoch_millis"
                    }
                  }
                }
              ],
              must_not: []
            }
          },
          size: 0,   
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
    end



    def searchBids(queryStr,startTime,endTime,maxSize=100)
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
                    "@timestamp": {
                      gte: startTime,
                      lte: endTime,
                      format: "epoch_millis"
                    }
                  }
                }
              ],
              must_not: []
            }
          },
          size: 0,   
          aggs: {
            "4": {
              terms: {
                field: "adid.keyword",
                size: maxSize,
                order: {
                  _count: "desc"
                  }
              },
              aggs: {
                "3": {
                  sum: {
                    field: "cost"
                    }
                }
              }
            }
          }
        }
    end

    def bidderStatus(queryStr,startTime,endTime,maxSize=100)
      {
      	"size": 0,
      	"query": {
      		"bool": {
      			"must": [{
      				"query_string": {
      					"query": queryStr,
      					"analyze_wildcard": true
      				}
      			}, {
      				"range": {
      					"@timestamp": {
      						"gte": startTime,
      						"lte": endTime,
      						"format": "epoch_millis"
      					}
      				}
      			}],
      			"must_not": []
      		}
      	},
      	"aggs": {
      		"4": {
      			"terms": {
      				"field": "hostname.keyword",
      				"size": maxSize,
      				"order": {
      					"1": "desc"
      				}
      			},
      			"aggs": {
      				"1": {
      					"max": {
      						"field": "campaigns"
      					}
      				},
      				"8": {
      					"terms": {
      						"field": "stopped",
      						"size": 5,
      						"order": {
      							"9": "desc"
      						}
      					},
      					"aggs": {
      						"1": {
      							"max": {
      								"field": "campaigns"
      							}
      						},
      						"5": {
      							"avg": {
      								"field": "qps"
      							}
      						},
      						"6": {
      							"min": {
      								"field": "qps"
      							}
      						},
      						"7": {
      							"max": {
      								"field": "qps"
      							}
      						},
      						"9": {
      							"max": {
      								"field": "@timestamp"
      							}
      						}
      					}
      				}
      			}
      		}
      	}
      }        
        
    end


   def graphCounts(queryStr,startTime,endTime,interval="1h",timezone=RTB_REPORT_TIMEZONE )
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
        "_source": {
          "excludes": []
        },
        "aggs": {
          "2": {
            "date_histogram": {
              "field": "@timestamp",
              "interval": interval,
              "time_zone": timezone,
              "min_doc_count": 1
            }
          }
        }
      }
    end

    def graphWinPrice(queryStr,startTime,endTime,interval="1h",timezone=RTB_REPORT_TIMEZONE)
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
        "_source": {
          "excludes": []
        },
        "aggs": {
          "2": {
            "date_histogram": {
              "field": "@timestamp",
              "interval": interval,
              "time_zone": timezone,
              "min_doc_count": 1
            },
            "aggs": {
              "1": {
                "avg": {
                  "field": "price"
                }
              }
            }
          }
        }
      }

    end

    def searchRequestsCountryCityMake(queryStr,startTime,endTime)
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
        "_source": {
          "excludes": []
        },
        "aggs": {
          "2": {
            "terms": {
              "field": "device.geo.country.keyword",
              "size": 5,
              "order": {
                "_count": "desc"
              }
            },
            "aggs": {
              "3": {
                "terms": {
                  "field": "device.geo.city.keyword",
                  "size": 5,
                  "order": {
                    "_count": "desc"
                  }
                },
                "aggs": {
                  "4": {
                    "terms": {
                      "field": "device.make.keyword",
                      "size": 5,
                      "order": {
                        "_count": "desc"
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

end


__END__




    # Use for bidder mysql data
  def home_mysql
      
     @summaries = {}
     offset = BIDDER_TIME_OFFSET  # Adjustment for differnt bidder time 
     @timeframes = {
        :last_hour => Time.now-3600 + (offset*3600),
        :last_8_hours =>  Time.now-(3600*8)  + (offset*3600),
        :last_24_hours =>  Time.now-(3600*24)  + (offset*3600),    
     }
     @totals = {}
     fields = [:clicks, :pixels, :wins, :bids, :win_price, :bid_price ]
     
     @timeframes.each do |k,v|
         k = k.to_sym
         @summaries[k.to_sym] = StatsRtb.select(
                       "campaign_id,"+
                       "SUM(stats_rtb.clicks) AS clicks,"+
                       "SUM(stats_rtb.pixels) AS pixels,"+
                       "SUM(stats_rtb.wins) AS wins,"+
                       "SUM(stats_rtb.bids) AS bids,"+
                       "SUM(stats_rtb.win_price) AS win_price,"+
                       "SUM(stats_rtb.bid_price) AS bid_price"
            ).where("stats_date > ?", v).group("campaign_id")   #[0]
        @totals[k] ||= {}             
         @summaries[k].each { |l| 
            fields.each {|f| 
                f = f.to_sym
                @totals[k][f] ||= 0
                @totals[k][f] += l.send(f)
            }
         }
     end      
               
     @campaigns = Campaign.order(:name)        
     
  end

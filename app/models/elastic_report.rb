class ElasticReport

    attr_accessor :value,:name
    
    def initialize(host)        
        return nil if not ELASTICSEARCH_ENABLE
        @client = Elasticsearch::Client.new log: false, host: host        #'52.90.13.120:9200'
        #client.transport.reload_connections!
    end
    
    def health
        @client.cluster.health
    end
    
    def queryCount(index,queryStr,startEpoch,endEpoch)        
        begin
            #queryStr2 = 'imp.banner.w: 728 AND imp.banner.h: 90 AND (ext.exchange: *smartyads*) AND ((-_exists_: imp.banner.mimes) OR imp.banner.mimes: *text\/javascript*)'
            countObj = {
              :query => {
                :bool => {
                  :must => [
                    {
                      :query_string => {
                        :analyze_wildcard => false,
                        :query => queryStr
                      }
                    },
                    {
                      "range" => {
                        "ext.timestamp" => {
                          "gte" => startEpoch,
                          "lte"=> endEpoch,
                          "format"=> "epoch_millis"
                        }
                      }
                    }
                  ],
                  :must_not => []
                }
              }
            }            
            @client.count index: index, body: countObj 
        rescue Exception=>e 
            { "error" => true , "count" => e.message }    
        end
    end    
        


    def querySearch(index,searchObj)        
        begin
            @client.search index: index, body: searchObj 
        rescue Exception=>e 
            { "error" => true , "count" => e.message }                
        end
    end    

    def indexLogRecord(index,msgtype,id,msgObj)
        begin
            @client.index  index: index, type: msgtype, id: id, body: msgObj , op_type: "index"        
        rescue Exception=>e 
            puts "index exception: #{e.message}"
            { "error" => true , "message" => e.message }                
        end
    end

    def getLastLogRecord(index,msgType)
        begin
            searchObj = {
                  query: {
                    bool: {
                      must: [
                        {
                          query_string: {
                            analyze_wildcard: true,
                            query: "_type:#{msgType}"
                          }
                        },
                      ]
                    }
                  },
                  size: 1,
                  sort: [
                    {
                      timestamp: {
                        order: "desc"
                      }
                    }
                  ]
                }
            if rec = @client.search( index: index, body: searchObj )
                if rec["hits"] and rec["hits"]["hits"] and rec["hits"]["hits"][0] and 
                    rec["hits"]["hits"][0]["_source"] and timestamp=rec["hits"]["hits"][0]["_source"]["timestamp"]
                    return timestamp/1000
                end
            end
            return nil    
        rescue Exception=>e 
            puts "get last log exception: #{e.message}"
            { "error" => true , "message" => e.message }                
        end        
        
    end
    
    
end

__END__


class ElasticReport

    attr_accessor :value,:name
	
	def initialize(host)		
		return nil if not ELASTICSEARCH_ENABLE
		@client = Elasticsearch::Client.new log: false, host: host		#'52.90.13.120:9200'
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


    
end

__END__

DOESN'T WORK???

			index = 'rtbinterval*'
			#queryStr2 = 'imp.banner.w: 728 AND imp.banner.h: 90 AND (ext.exchange: *smartyads*) AND ((-_exists_: imp.banner.mimes) OR imp.banner.mimes: *text\/javascript*)'
			startEpoch = 1475192776222
			endEpoch = 1480380376222
			
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
			              "gte" => 1475193264033,
			              "lte"=> 1480380864033,
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
			
			
			
			countObj = {
			  "size" => 0,
			  "query"=> {
			    "bool"=> {
			      "must"=> [
			        {
			          "query_string"=> {
			            "analyze_wildcard"=> true,
			            "query"=> queryStr
			          }
			        },
			        {
			          "range"=> {
			            "ext.timestamp"=> {
			              "gte"=> startEpoch,
			              "lte"=> endEpoch,
			              "format"=> "epoch_millis"
			            }
			          }
			        }
			      ],
			      "must_not"=> []
			    }
			  }
			}			
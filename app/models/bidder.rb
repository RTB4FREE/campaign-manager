class Bidder

	require 'json';
	require "net/https";
	require "open-uri"  
    

	# Ping not implemented on bidders yet
	def self.ping()
		crosstalk_hosts = RTB_CROSSTALK_REGION_HOSTS
		crosstalk_hosts.each do |region,host|
			puts "Pinging bidder #{host}"
			return nil if bidderCmd( "Ping#").nil?
		end
		"ok"
	end

	def self.updateAll()
		puts "Bidder update all called."
		bidderCmd( "Refresh#")
	end

	def self.updateCampaign(campId,target_regions=nil)
		bidderCmd( "Update#",campId,target_regions)
	end

	def self.deleteCampaign(campId,target_regions=nil)
		bidderCmd( "Delete#",campId,target_regions)
	end

	def self.loadS3(settype,name,s3path)
	     payload = "load S3 #{settype} #{name} #{s3path}"	     
	     puts "loadS3 payload: #{payload}"
	     bidderCmd( "ConfigureAws#",nil,nil,payload)
	 end


	def self.bidderCmd(command,campId=nil,target_regions=nil,commandpayload=nil)
		crosstalk_hosts = RTB_CROSSTALK_REGION_HOSTS
		postObj = { username:  "#{RTB_CROSSTALK_USER}", password: "#{RTB_CROSSTALK_PASSWORD}", type: command }
		postObj.merge!({ command: commandpayload }) if commandpayload
		resp = nil
		if not campId.nil? 
			postObj.merge!({campaign: campId})
			postObj.merge!({async: true })
			postJson = postObj.to_json
			if not target_regions.to_s.empty?   
				# send to designated region's crosstalk
				target_regions.to_s.split(',').each do |target_region|    			
					if target_host = crosstalk_hosts[target_region.to_s]
						resp = callHttp("POST","http://#{target_host}:#{RTB_CROSSTALK_PORT}","api",{},postJson)
					else
						Rails.logger.error "Error sending to region #{target_region}. Crosstalk host not defined in #{crosstalk_hosts}"
					end
				end
			else
				# Send to all region's crosstalks
		    	crosstalk_hosts.each do |region,host|				
			    	resp = callHttp("POST","http://#{host}:#{RTB_CROSSTALK_PORT}","api",{},postJson )
			    end
			end
	    else
	    	postJson = postObj.to_json
	    	crosstalk_hosts.each do |region,host|				
		    		resp =  callHttp("POST","http://#{host}:#{RTB_CROSSTALK_PORT}","api",{},postJson )
		    end
	    end	
	    resp
	end

    def self.callHttp(type,url,methodPath,formObj,body="")
    	begin
	        uri = URI(url+"/#{methodPath}")	        
	        uri.query = URI.encode_www_form(formObj) 
	        if type.eql?("GET")
	        	request = Net::HTTP::Get.new(uri.request_uri)
			    elsif type.eql?("POST")
		        request = Net::HTTP::Post.new(uri.request_uri)
		        request['Content-Type'] = 'application/json'
	        elsif type.eql?("PUT")
				    request = Net::HTTP::Put.new(uri.request_uri)
				    request['Content-Type'] = 'application/json'
			    elsif type.eql?("DELETE")
				    request = Net::HTTP::Delete.new(uri.request_uri)
			    else
				    puts "Unknown HTTP type #{type}"
				    raise "Unknown HTTP type #{type}"
	        end
	        # Request body
	        request.body = body        
	        response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https', :read_timeout => 180, :open_timeout => 10) do |http|	
	            http.request(request)
	        end
	        if response and response.kind_of? Net::HTTPSuccess
	          resp = response.body
	        else
	          resp = nil
	        end
	    rescue Exception => e
            Rails.logger.error  "Exception error #{e.message}"			
			#puts e.backtrace			
			resp = nil
		  end			
		  response ||= {}
		  puts "Response for #{url}/#{methodPath}, form #{uri.query.inspect}, body #{body.inspect}\n\n  #{response.to_json}\n"
		  Rails.logger.info  "resp #{resp.inspect}"
		  return resp
	  end    
	  	  

end
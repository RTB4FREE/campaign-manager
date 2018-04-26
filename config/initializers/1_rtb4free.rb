

def env_replace(name,val,type="string")
    if ENV[name] 
        val = ENV[name]  
    end
    case type
    when "string"
        eval("#{name} = \"#{val}\"")  
    when "boolean"
        if val.to_s=~/^true/i
            val="true"
        elsif val.to_s=~/^false/i
            val="false"
        end
        eval("#{name} = #{val}")  
    when "number"
        eval("#{name} = #{val}")
    when "hash"
        eval("#{name} = #{val}")
    end
    puts "Setting #{name} to #{val} (#{type})"
end

# Header label
env_replace("CUSTOMER_NAME","RTB4FREE-Demo")

# Bidder timezone offset from GMT. Assumes bidder time is GMT
env_replace("BIDDER_TIME_OFFSET",0,"number")

#
#
# Defaults for docker deploy
#
env_replace("RTB4FREE_DATABASE_HOST","localhost")
env_replace("RTB4FREE_DATABASE_PORT",3306,"number")
env_replace("RTB4FREE_DATABASE_USERNAME","root")
env_replace("RTB4FREE_DATABASE_PASSWORD","")
env_replace("RTB4FREE_DATABASE_NAME","rtb4free")


#
# Define elasticsearch hosts that contain RTB log data
# Report controllers use this to query ES
#
env_replace("ELASTICSEARCH_ENABLE", false,"boolean")
env_replace("ELASTICSEARCH_HOST",'elastic1:9200')
env_replace("ELASTICSEARCH_KIBANA_URL","http://kibana:5601")
env_replace("ELASTICSEARCH_HOSTS", '{"US" => "elastic1:9200"}', "hash")

#
# Elasticsearch indexes for requests
#
env_replace("ELASTICSEARCH_REQUESTS_INDEX", "requests-*")
env_replace("ELASTICSEARCH_BIDS_INDEX", "bids-*")
env_replace("ELASTICSEARCH_WINS_INDEX", "wins-*")
env_replace("ELASTICSEARCH_PIXELS_INDEX", "pixels-*")
env_replace("ELASTICSEARCH_CLICKS_INDEX", "clicks-*")
env_replace("ELASTICSEARCH_STATS_INDEX", "status-*")

#
# Crosstalk hosts. 
# Define the Regions that this campaign manager will manage. 
# Each region must have a Crosstalk host. Campaign Manager will send updates to the campaign region's Crosstalk.
#
env_replace("RTB_CROSSTALK_REGION_HOSTS", '{"US" => "crosstalk"}', "hash")

# Match this setting to Crosstalk's config.json file setting.
env_replace("RTB_CROSSTALK_PORT", "8100")
env_replace("RTB_CROSSTALK_USER", "ben*")
env_replace("RTB_CROSSTALK_PASSWORD", "test")

#
# Set if your bidder is using large lists.  To store this data in AWS S3, put access info here.
# Amazom Keys for S3 UPLOADED FILES, user fbapp_s3 
#
env_replace("AWS_ACCESS_KEY_S3", "XXXXXXXX")
env_replace("AWS_SECRET_KEY_S3", "XXXXXXXX")
env_replace("AWS_REGION_S3", "us-east-1")
env_replace("AWS_S3_BUCKET", "my-rtb4free-bidder-lists")
env_replace("AWS_S3_BASE_URL", "https://s3.amazonaws.com/#{AWS_S3_BUCKET}")
env_replace("RTB_REPORT_TIMEZONE", "America/Los_Angeles")




      
      
      
      




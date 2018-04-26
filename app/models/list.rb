class List < ActiveRecord::Base
	
    has_many :rtb_standards, :foreign_key => :operand_list_id   
    has_many :targets, :foreign_key => :domains_list_id   
    
    
             
    before_update :set_updated_at

    def set_updated_at
       self.updated_at = Time.now         
    end

    def set_campaign_updated_at       
        if campaigns = self.campaigns
            campaigns.each do |campaign|
                campaign.set_updated_at
                campaign.save
               # campaign.update_bidder
            end
        end
    end


	# Remove media object from item
	def mediaObjectDelete(id,attachto,path)

	end

	# Put the file to S3
	def self.putAwsS3(awsKey,awsSecret,awsRegion,awsS3Bucket,awsS3Key,mediaType,data,metadata={})
		client = Aws::S3::Client.new(
		  region: awsRegion,
		  credentials: Aws::Credentials.new(awsKey,awsSecret)
		)
		options = {
			:body => data, 					# file/IO object, or string data
			:bucket => awsS3Bucket,
			:key => awsS3Key,
			:content_type => mediaType,
			:metadata => Hash[ metadata.map { |k, v| [k.to_s, v.to_s] } ]
		}
		resp = client.put_object(options)
	end


	def self.removeS3Object(key)
		key.sub!(/\/#{AWS_S3_BUCKET}\//,"")
        cred = Aws::Credentials.new(AWS_ACCESS_KEY_S3,AWS_SECRET_KEY_S3)
		puts "Removing key #{key}"
		s3Client = Aws::S3::Client.new(
		  region: AWS_REGION_S3,
		  credentials: cred
		)
		s3Client.delete_object({
		  bucket: AWS_S3_BUCKET, # required
		  key: key,      # required
		})			
	end

	# Only used for test
	def self.listS3Object
        cred = Aws::Credentials.new(AWS_ACCESS_KEY_S3,AWS_SECRET_KEY_S3)
		s3Client = Aws::S3::Client.new(
		  region: AWS_REGION_S3,
		  credentials: cred
		)			
		s3Client.list_objects(bucket: AWS_S3_BUCKET).contents.each do |object|
	    	puts "#{object.key}\t#{object.size}"
		end		
	end


	#
	# tags = array of { key: xxx, value: xxx}
	#
	def self.putS3ObjectTags(key,tags=[])
		key.sub!(/\/#{AWS_S3_BUCKET}\//,"")
		puts "Updating tags for key: #{key}"
		
        cred = Aws::Credentials.new(AWS_ACCESS_KEY_S3,AWS_SECRET_KEY_S3)
		s3Client = Aws::S3::Client.new(
		  region: AWS_REGION_S3,
		  credentials: cred
		)
		s3Client.put_object_tagging({
		  bucket: AWS_S3_BUCKET, # required
		  key: key, # required
		  tagging: { # required
		    tag_set: tags
		  },
		  use_accelerate_endpoint: false,
		})
	end


end

__END__


#	field :name, type:String, :default => ""
#	field :description, type:String, :default => ""
#	field :type, type:String, :default => ""	
#	field :s3_url, type:String, :default => ""
#	field :filepath, type:String, :default => ""
#	field :filetype, type:String, :default => ""	
#	field :last_modified, type:String, :default => "" 
#	field :filesize, type:Integer, :default=>0
#   field :user_ref, type:String, :default => "" 
#    field :enable, type:Boolean, :default => true 

#    validates :name, :presence => true   

#    after_update :set_campaign_updated_at
#    after_create :set_campaign_updated_at

	

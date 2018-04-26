class Target < ActiveRecord::Base

    has_many :campaigns
    has_many :banners
    has_many :banner_videos
    belongs_to :list, :foreign_key => :domains_list_id
    
    before_update :set_updated_at
    after_update :set_campaign_updated_at
    after_create :set_campaign_updated_at
    
    validates :name,:activate_time,:expire_time, :presence => true
    validate :expire_time_cannot_be_in_the_past
    
    def set_updated_at
       self.updated_at = Time.now         
    end        

    def set_campaign_updated_at       
         if campaigns=self.campaigns  
            campaigns.each do |campaign|
                campaign.set_updated_at
                campaign.save
            end
        end
    end

    def expire_time_cannot_be_in_the_past
        if expire_time.present? && expire_time < Time.now
          errors.add(:expire_time, "can't be in the past")
        end
        if activate_time.present? && expire_time.present? && activate_time > expire_time
          errors.add(:expire_time, "can't be before activate time")
        end
    end  


    def check_time    
        if  (activate_time=self.activate_time and activate_time > Time.now) or 
            (expire_time=self.expire_time and expire_time < Time.now)   
        then    
            return false
        end
        return true
    end        

    def check_errors
        errors = []
        #if not self.check_time
        #    errors.push("Target active time is not in current time.") 
        #end
      #  puts "Checking expire_time #{self.expire_time.to_i}, now #{Time.now.to_i}"
        if self.expire_time and (self.expire_time < Time.now) 
            errors.push("Expire time in the past.")
        end
        if self.activate_time and (self.activate_time > Time.now) 
            errors.push("Activate time in the future.")
        end
        errors
    end

    
end

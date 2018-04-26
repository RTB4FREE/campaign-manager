class Campaign < ActiveRecord::Base
    
    
    has_many :banners, :dependent => :destroy
    belongs_to :target
    has_many :banner_videos, :dependent => :destroy
    has_and_belongs_to_many :rtb_standards
    
    validates :name,:activate_time,:expire_time,:ad_domain,:regions, :presence => true
    validates :total_budget, :presence => true, numericality: { greater_than: 0 }
    validate :expire_time_cannot_be_in_the_past
    
    before_update :set_updated_at
    before_update :check_exchange_attributes
    
    
    def expire_time_cannot_be_in_the_past
        if expire_time.present? && expire_time < Time.now
          errors.add(:expire_time, "can't be in the past")
        end
        if expire_time.present? && activate_time.present? && expire_time < activate_time
          errors.add(:expire_time, "can't be before activate time")
        end
    end    

    def check_errors
        errors = []
       # puts "Checking total_budget #{self.total_budget}"
        if self.status.to_s.eql?("runnable")
            # Check budget versus cost
            if cost=self.cost and budget=self.total_budget and 
               cost.to_f>0 and 
               (cost.to_f > budget.to_f) 
            then
                errors.push("Campaign not loaded - total cost #{sprintf('%.2f', cost)} greater than budget #{sprintf('%.2f', budget)}")
            end

            if cost=self.daily_cost and budget=self.budget_limit_daily and 
               cost.to_f>0 and 
               (cost.to_f > budget.to_f) 
            then
                errors.push("Campaign not loaded - daily cost #{sprintf('%.2f', cost)} greater than budget #{sprintf('%.2f', budget)}")
            end

            if cost=self.hourly_cost and budget=self.budget_limit_hourly and 
               cost.to_f>0 and 
               (cost.to_f > budget.to_f) 
            then
                errors.push("Campaign not loaded - hourly cost #{sprintf('%.2f', cost)} greater than budget #{sprintf('%.2f', budget)}")
            end

            if self.cost and self.total_budget and 
               self.cost.to_f>0 and 
               (self.cost.to_f > self.total_budget.to_f) 
            then
                errors.push("Campaign not loaded! Cost #{self.cost.to_f} greater than budget #{self.total_budget.to_f}")
            end
            
            if self.expire_time and (self.expire_time < Time.now) 
                errors.push("Campaign time expired!")
            end
            if self.activate_time and (self.activate_time > Time.now) 
                errors.push("Campaign time not yet active.")
            end
        #    logger.info "Checking creatives are defined, banners #{self.banners.inspect}, videos #{self.banner_videos.inspect}"
            if self.banners.empty?() and self.banner_videos.empty?()
                errors.push("No banners or videos have been defined.")
            else
                total_creative_errors = 0
                self.banners.each do |banner|
                    if creative_errors = banner.check_errors and creative_errors.length>0                    
                        total_creative_errors += 1
                    end
                end
                self.banner_videos.each do |video|
                    if creative_errors = video.check_errors and creative_errors.length>0                    
                        total_creative_errors += 1
                    end                    
                end
                if total_creative_errors==(self.banners.length+self.banner_videos.length)
                    errors.push("All #{total_creative_errors} creatives are invalid. Campaign not loaded.")
                end
            end
            
            if not self.target or self.target.to_s.empty?()
                errors.push("Campaign not loaded - target is not defined.")
            elsif tObj=Target.find(self.target.id) and not tObj.check_time
               errors.push("Campaign not loaded - target \"#{tObj.name}\" time not active.")    
            end            
        end
        errors
    end

    def set_updated_at
       self.updated_at = Time.now
    end


    def update_bidder
       #
       # Signal campaign has been updated  
       #                   
        puts "Bidder update called for campaign #{self.id.to_s}"
        if not Bidder.ping
            puts "Unable to ping bidder."
            return false 
        end
        if not Bidder.updateCampaign(self.id.to_s,self.regions)
        #if not Bidder.updateAll()
            puts "Bidder/crosstalk update error for campaign id #{self.id}."
        end
        return true
    end

    def remove_bidder
        puts "Bidder remove called for campaign #{self.id.to_s}"
        return false if not Bidder.ping
        if not Bidder.deleteCampaign(self.id.to_s)
            puts "Bidder/crosstalk update error."
        end
        return true
    end

    def check_exchange_attributes
        campaign_exchanges = self.exchanges.to_s.split(",")
        self.banners.each do |banner|
            banner.exchange_attributes.each do |attr|
                puts "Checking campaign #{self.name} if banner attribute #{attr.name}, exchange #{attr.exchange} is in #{campaign_exchanges.inspect}"
                if not campaign_exchanges.include?(attr.exchange)
                    attr.destroy 
                    puts "\tDeleted attribute #{attr.name}"
                end
            end
        end
        self.banner_videos.each do |video|
            video.exchange_attributes.each do |attr|
                puts "Checking campaign #{self.name} video attribute #{attr.name}, exchange #{attr.exchange} is in #{campaign_exchanges.inspect}"
                if not campaign_exchanges.include?(attr.exchange)
                    attr.destroy 
                    puts "\tDeleted attribute #{attr.name}"
                end
            end
        end        
        
    end

end
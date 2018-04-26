class Banner < ActiveRecord::Base
    
    belongs_to :campaign
    belongs_to :target
    has_and_belongs_to_many :rtb_standards
    has_many :report_commands
    has_many :exchange_attributes, dependent: :destroy
    
    validates :name, :interval_start,:interval_end,:iurl,:htmltemplate,:contenttype , :presence => true
    validates :bid_ecpm,  :numericality => { :allow_blank => false }, :presence => true
    validate :interval_end_cannot_be_in_the_past
    
    validates_format_of :width_range, :with => /\A\d+-\d+\Z/ , :allow_blank => true,  message: "Invalid format. Must be <number>-<number>" 
    validates_format_of :height_range, :with =>/\A\d+-\d+\Z/, :allow_blank => true,    message: "Invalid format. Must be <number>-<number>" 
    validates_format_of :width_height_list, :with => /\A[\dx,]+\Z/, :allow_blank => true,    message: "Invalid format. Must be <number>x<number>,<number>x<number>,..." 
    
    
    
    before_update :set_updated_at
    after_update :set_campaign_updated_at
    after_create :set_campaign_updated_at
    
    def interval_end_cannot_be_in_the_past
        if interval_end.present? && interval_end < Time.now
          errors.add(:interval_end, "can't be in the past")
        end
        if interval_end.present? && interval_start.present? && interval_end < interval_start
          errors.add(:interval_end, "can't be before interval start")
        end
    end            

    def check_errors
        errors = []
        # Check budget versus cost
        if cost=self.total_cost and budget=self.total_basket_value and 
           cost.to_f>0 and 
           (cost.to_f > budget.to_f) 
        then
            errors.push("Total cost #{sprintf('%.2f', cost)} greater than budget #{sprintf('%.2f', budget)}")
        end
        if cost=self.daily_cost and budget=self.daily_budget and 
           cost.to_f>0 and 
           (cost.to_f > budget.to_f) 
        then
            errors.push("Daily cost #{sprintf('%.2f', cost)} greater than budget #{sprintf('%.2f', budget)}")
        end
        if cost=self.hourly_cost and budget=self.hourly_budget and 
           cost.to_f>0 and 
           (cost.to_f > budget.to_f) 
        then
            errors.push("Daily cost #{sprintf('%.2f', cost)} greater than budget #{sprintf('%.2f', budget)}")
        end
            
      #  puts "Checking expire_time #{self.expire_time.to_i}, now #{Time.now.to_i}"
        if self.interval_end and (self.interval_end < Time.now) 
            errors.push("Interval end time expired!")
        end
        if self.interval_start and (self.interval_start > Time.now) 
            errors.push("Interval start time not yet active.")
        end
        errors
    end

    def set_updated_at
       self.updated_at = Time.now         
    end

    def set_campaign_updated_at       
        if campaign = self.campaign
            campaign.set_updated_at
            campaign.save
        end
    end

end
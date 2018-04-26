class RtbStandard < ActiveRecord::Base

    belongs_to :campaign
    has_many :banners
    has_many :banner_videos
    has_and_belongs_to_many :campaigns
    has_and_belongs_to_many :banners
    has_and_belongs_to_many :banner_videos

    #  operand_list_id
    belongs_to :list, :foreign_key => :operand_list_id
   
    validates :name,:rtbspecification, :presence => true
   
   before_update :set_updated_at
   after_update :set_campaigns_updated_at
   after_create :set_campaigns_updated_at
   
    def set_updated_at
       self.updated_at = Time.now         
    end

   def set_campaigns_updated_at       
        if campaigns = self.campaigns
            campaigns.each { |campaign| 
                campaign.set_updated_at
                campaign.save
            }
        end
    end
    
end

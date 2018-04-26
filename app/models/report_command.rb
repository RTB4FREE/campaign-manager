class ReportCommand < ActiveRecord::Base

    belongs_to :campaign
    belongs_to :banner
    belongs_to :banner_video

end

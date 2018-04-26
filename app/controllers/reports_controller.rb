class ReportsController < ApplicationController


    before_filter :authorize

    def home      
         @offset = BIDDER_TIME_OFFSET   # Adjustment for differnt bidder time 
         @banners = Banner.order(:name)  
         @elastic = ElasticReport.new(ELASTICSEARCH_HOST)    
         @interval_options = [
                    {
                        sym: "m",
                        secs: 60,
                        label: "minutes"
                    },
                    {
                        sym: "h",
                        secs: 3600,
                        label: "hours"
                    },
                    {
                        sym: "d",
                        secs: 24*3600,
                        label: "days"
                    },
                    {
                        sym: "w",
                        secs: 24*3600*7,
                        label: "weeks"
                    },
        ]
        
        @interval_ago = params[:interval_ago].to_i if params[:interval_ago]
        @interval_sym = params[:interval_sym] if params[:interval_sym]
        # set defaults
        @interval_ago ||= 1
        @interval_sym ||= "d"
    end

end

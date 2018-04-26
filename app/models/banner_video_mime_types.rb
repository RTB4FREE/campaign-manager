class BannerVideoMimeTypes < ActiveRecord::Base
    
    
    def self.all
        [
            { name:"video/mp4"},
            { name:"video/ogg"},
            { name:"video/x-flv"},
            { name:"video/webm"},
            { name:"video/MP2T"},
            { name:"video/3gpp"},
            { name:"video/quicktime"},
            { name:"video/x-msvideo"},
            { name: "application/x-mpegURL"},
            { name: "application/x-shockwave-flash"},
            { name: "application/javascript"}
        ]
    end
    
end

__END__
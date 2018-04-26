class VastVideoType < ActiveRecord::Base
    
    # http://www.iab.net/media/file/OpenRTB-API-Specification-Version-2-3.pdf   section 5.7    
    
    attr_accessor :value,:description

    def self.all
        [
            { value:"1", description: "VAST 1.0"},
            { value:"2", description: "VAST 2.0"},
            { value:"3", description: "VAST 3.0"},
            { value:"4", description: "VAST 1.0 Wrapper"},
            { value:"5", description: "VAST 2.0 Wrapper"},
            { value:"6", description: "VAST 3.0 Wrapper"}
        ]
    end
    
    
end

__END__




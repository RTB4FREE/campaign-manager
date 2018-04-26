class DeviceType < ActiveRecord::Base
    
    
    def self.all
        [
            { value:"1", description: "Mobile/Tablet"},
            { value:"2", description: "Personal Computer"},
            { value:"3", description: "Connected TV"},
            { value:"4", description: "Phone" },
            { value:"5", description: "Tablet"},
            { value:"6", description: "Connected Device" },
            { value:"7", description: "Set Top Box" }   
        ]
    end
    
end

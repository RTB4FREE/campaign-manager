class Region < ActiveRecord::Base
    
    
    def self.all
        [
            { name:"US", label: "United States" },
            { name:"EU", label: "Europe"},
            { name:"AP", label: "Asia Pacific"},
            { name:"RU", label: "Russia"},
            { name:"NL", label: "Netherlands"}
        ].sort_by{|i| i[:label] }
    end
    
end


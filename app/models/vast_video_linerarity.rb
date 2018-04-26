class VastVideoLinerarity

    attr_accessor :value,:description

    def self.all
        [
            { value:"1", description: "Linear / In-Stream"},
            { value:"2", description: "Non-Linear / Overlay"}
        ]
    end
    
end

__END__

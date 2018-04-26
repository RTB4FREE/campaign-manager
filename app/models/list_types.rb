class ListTypes < ActiveRecord::Base
    
    
    def self.all
        [
            { 
                name:"range",
                label: "Range List", 
                description: "IP list in the form a.b.c.d - 1.2.3.4"
            },
            { 
                name:"cidr",
                label: "CIDR List", 
                description: "CIDR x.x.x.x/n"
            },
            { 
                name:"map",
                label: "Map", 
                description: "Comma separated values, Line 1 has the key names."
            },
            { 
                name:"set",
                label: "Set", 
                description: "A set (unique list), memory intensive."
            },
            { 
                name:"bloom",
                label: "Bloom Filter", 
                description: "A set ordered as a Bloom filter, space saving. No deletes."
            },
            { 
                name:"cuckoo",
                label: "Cuckoo Filter", 
                description: "A set ordered as a cuckoo filter. space saving. Can delete."
            },
            { 
                name:"rawcookie",
                label: "Raw Cookie", 
                description: "A set of cookies with the campaigns they belong to."
            },
            { 
                name:"redis",
                label: "Redis Proxy", 
                description: "A redis construct host:port, rest of lines are object names of what is exposed."
            },
            { 
                name:"script",
                label: "Script", 
                description: "Java script functions."
            }
        ]
    end
    
end

__END__

range                           IP list in the form a.b.c.d - 1.2.3.4
cidr                              CIDR x.x.x.x/n
map                            Comma separated values, Line 1 has the key names
set                              A set (unique list), memory intensive
bloom                         A set ordered as a Bloom filter, space saving. No deletes.
cuckoo                       A set ordered as a cuckoo filter. space saving. Can delete
redis                          A redis construct host:port, rest of lines are object names of what is exposed.
script                          Java script functions
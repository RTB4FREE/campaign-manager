
require "csv"

namespace :import do
  desc "Imports IAB categories."
  task :seed_iab => :environment do
      # rub with rake import:seed_iab

        IabCategory.destroy_all
        file = File.new("#{Rails.root}/lib/tasks/iab_categories.txt", "r")
        group = ""
        while (line = file.gets)
            next if line.strip.empty?
            puts "Processing line #{line}"
            if line=~/^###(\S+)\s(.*)$/
                iab_id = $1.strip
                group=$2.strip
                IabCategory.create(group: group, name: group, iab_id: iab_id, is_group: true)
                puts "created group #{iab_id}, #{group}"
            elsif line=~/^(\S+)\s(.*)$/
                iab_id = $1.strip
                name=$2.strip
                IabCategory.create(group: group, name: name, iab_id: iab_id, is_group: false)    
                puts "\tcreated category #{iab_id}, #{name}"
            else 
                puts "\t!!! Invalid line !!!!!"
            end        
        end
    end
    
    
    
    desc "Imports countries."
    task :seed_countries => :environment do
      # rub with rake import:seed_countries
        Country.destroy_all
        file = File.new("#{Rails.root}/lib/tasks/iso_3166_2_countries.csv", "r")
        headers = []
        while (line = file.gets)
            line.chomp!
            next if line.strip.empty?
            puts "Processing line #{line}"
            #fields = line.split(/,/)            
            fields = line.parse_csv
            if headers.empty?
                fields.each { |field|
                    next if field.to_s.strip.empty?
                    field.gsub!(/\s/,"_")
                    field.downcase!
                    field = "country_type" if field.eql?("type")  # Can't use type col in mysql
                    headers.push(field)
                }
                puts "Setting headers #{headers}"
                next
            end                        
            next if fields[0]!~/^\d+$/
            tmp = {}
            headers.each_with_index{ |h,i| tmp[h]=fields[i]}
            puts "create country #{tmp}"
            Country.create(tmp)            
        end
    end

    desc "Imports rtbspecs."
    task :seed_rtbspecs => :environment do
      # rub with rake import:seed_rtbspecs
        ExchangeRtbspecs.destroy_all
        file = File.new("#{Rails.root}/lib/tasks/smarty_ads_rtbspecs.csv", "r")
        headers = []
        while (line = file.gets)
            line.chomp!
            next if line.strip.empty?
            puts "Processing line #{line}"
            #fields = line.split(/,/)            
            fields = line.parse_csv
            if headers.empty?
                fields.each { |field|
                    next if field.to_s.strip.empty?
                    field.gsub!(/\s/,"_")
                    field.downcase!
                    headers.push(field)
                }
                puts "Setting headers #{headers}"
                next
            end                        
            tmp = {}
            headers.each_with_index{ |h,i| tmp[h]=fields[i].strip}
            puts "create rtbspec #{tmp}"
            ExchangeRtbspecs.create(tmp)            
        end

    end



end
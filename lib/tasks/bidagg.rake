#
# Execute:  rake bidagg:campaigns
#
namespace :bidagg do


  def lockfile(name)
    # Assuming you're running Rails
    Rails.root.join('tmp', 'pids', "#{name}.lock")
  end
  
  def running!(name)
    #`touch #{lockfile(name)}`
    File.open(lockfile(name), 'w') {|f| f.write("#{Process.pid}") }
  end
  
  def done!(name)
    `rm #{lockfile(name)}`
  end

  def running?(name)
    File.exists?(lockfile(name))
    #  oldpid = File.read(file_name)      
  end


  desc "Aggregate campaign performance into ELasticsearch index."
  task :campaigns => :environment do
        name = "campaigns"
        if running?(name)
          puts "#{name} aggregation is already running. Skip this cycle."
        else
          running!(name)
          begin
            ReportAggregation.campaignPerformance3
            ReportAggregation.campaignTableSpendUpdate
          rescue Exception => e  
            puts e.message  
            RakeLogger.info e.message
            RakeLogger.info e.backtrace.inspect
          end          
          done!(name)
        end
   end    

end



__END__

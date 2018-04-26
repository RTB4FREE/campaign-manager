class Attachment < ActiveRecord::Base


  def uploaded_file=(incoming_file)
    self.filename = incoming_file.original_filename
    self.content_type = incoming_file.content_type
    self.data = incoming_file.read
  end

  def filename=(new_filename)
    write_attribute("filename", sanitize_filename(new_filename))
  end

  def uploaded_file_ZOOKEEPER=(incoming_file)
    self.filename = incoming_file.original_filename
    self.content_type = incoming_file.content_type
    name = incoming_file.original_filename
    #directory = "public/test"
    #path = File.join(directory, name)
    #File.open(path, "wb") { |f| f.write( incoming_file.read) }    
    
    zk = ZK.new("rtb4free.com:2181")    
    zk.create( "/rtbfiles/#{name}", incoming_file.read  )
    resp = zk.children("/rtbfiles")
    puts "Zookeeper children: "+resp.inspect

  end


  private
  def sanitize_filename(filename)
    #get only the filename, not the whole path (from IE)
    just_filename = File.basename(filename)
    #replace all non-alphanumeric, underscore or periods with underscores
    just_filename.gsub(/[^\w\.\-]/, '_')
  end


end

__END__
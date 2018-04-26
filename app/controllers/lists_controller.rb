#encoding: utf-8
class ListsController < ApplicationController
  
  before_action :set_list, only: [:show, :edit, :update, :destroy]
	require 'json';

	skip_before_action :verify_authenticity_token, only: [:upload]  # Fix for this error http://stackoverflow.com/questions/3364492/actioncontrollerinvalidauthenticitytoken

	before_filter :authorize		

  def index
    @lists = List.order(:name)
  end

	def new
	    @list = List.new
	end

  def show
  end

	def edit	
		#@list = List.where(user_ref:current_user.id.to_s).find(params[:submit])
	end

	def create
		@list = List.new(list_params(params))
    respond_to do |format|
      if @list.save
        #@list.campaign.update_bidder if @banner.campaign
        format.html { redirect_to @list, notice: 'List was successfully created.' }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
	end
	
	

	def list_params(params)
		params.require(:list).permit(:name,:description,:list_type,:filetype,:filepath,:filesize,:s3_url,:last_modified)  
  	end

	def update
    if params[:list] and @list = List.find_by_id(params[:list][:id])
	    	resp = @list.update_attributes(list_params(params))
	     	if resp then
		  		puts "List saved."
		  		tags = [
		  				{ key: "name", value: @list.name.to_s },
		  				{ key: "type", value: @list.list_type.to_s }
		  		]
		  		resp = List.putS3ObjectTags(@list.filepath.to_s,tags)		  		
		  		puts "update tags response: #{resp.inspect}"
		  		Bidder.loadS3(@list.list_type.to_s, @list.name.to_s,@list.filepath.to_s.sub(/\/#{AWS_S3_BUCKET}\//,""))
		  		redirect_to '/lists', notice: "List #{@list.name} was successfully updated."
		  		return
		  	else
				puts "List save error: #{@list.errors.messages.inspect}"
				redirect_to @list, alert: @list.errors.full_messages
				return
			end
		else
			redirect_to '/lists', alert: "Update failed - entry not found."
			return		
		end
	end

	def destroyXXXX
	    if @list = List.find_by_id(params[:id])
			List.removeS3Object(@list.filepath.to_s)
		    name = @list.name
		    @list.destroy
		    notice = "List #{name} was successfully deleted."
		else
			notice = "Error deleting entry."
		end
	    redirect_to '/lists/index', notice: notice
	end

  def destroy
    if @list
		  resp = List.removeS3Object(@list.filepath.to_s)
		  
		  puts "Delete s3 response #{resp.inspect}"
		  
		  name = @list.name
		  @list.destroy
		  notice = "List #{name} was successfully deleted."
		else
			notice = "Error deleting entry."
		end
    respond_to do |format|
      format.html { redirect_to lists_url, notice: notice }
      format.json { head :no_content }
    end
  end


	def upload
		params.each{ |k,v| puts "#{k}=#{v.inspect}" }
		listId = params["listId"].to_s,		
		attrs = {
				:filetype  =>  params["filetype"],
				:filepath => URI.unescape(params["filepath"]),
				:filesize => params["filesize"],
				:s3_url =>  URI.unescape(params["url"]),  
				:last_modified => params["lastModifiedDate"]
		}	
		puts "Upload attributes: #{attrs}"
		@list = List.find_by_id(listId)
		if listId.empty? or not @list
			attrs[:name] = params["filename"]
			@list = List.new(attrs)			
			if @list.save then
		  		puts "List saved."
		  		render :layout=>false, :text=>""
		  		return
		  	else
				puts "List save error: #{@list.errors.messages.inspect}"
				render :layout=>false, :text=>"Error"
				return
			end
		else
			puts "List update."
			List.removeS3Object(URI.unescape(@list.filepath))
			@list.update_attributes(attrs)
		end
		render :layout=>false, :text=>""
	end


	private

    def set_list
      @list = List.find(params[:id])
    end

end

__END__


Upload params
{
	"url"=>"https://s3.amazonaws.com/fbapp-media/uploads%2F57a7c7c0685a070b72000009%2F57b24893685a07183d000002%2FComingSoon.jpg", 
	"filepath"=>"/fbapp-media/uploads%2F57a7c7c0685a070b72000009%2F57b24893685a07183d000002%2FComingSoon.jpg", 
	"filename"=>"ComingSoon.jpg", 
	"filesize"=>"9374", 
	"lastModifiedDate"=>"Tue May 24 2016 12:16:16 GMT-0700 (PDT)", 
	"filetype"=>"image/jpeg", 
	"unique_id"=>"kghls0rm9p45haf4", 
	"attachto"=>"description", 
	"file_url"=>"https://s3.amazonaws.com/fbapp-media/uploads%2F57a7c7c0685a070b72000009%2F57b24893685a07183d000002%2FComingSoon.jpg"
}
		
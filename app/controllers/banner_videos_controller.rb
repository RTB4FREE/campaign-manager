class BannerVideosController < ApplicationController
  before_action :set_banner_video, only: [:show, :edit, :update, :destroy]

  before_filter :authorize

  # GET /banner_videos
  # GET /banner_videos.json
  def index
    @banner_videos = BannerVideo.order(:name)
  end

  # GET /banner_videos/1
  # GET /banner_videos/1.json
  def show
  end

  # GET /banner_videos/new
  def new
    @banner_video = BannerVideo.new
    # Set defaults
    @banner_video.frequency_spec ||= "device.ip"    
    @banner_video.interval_start ||= Time.now
    @banner_video.interval_end ||= Time.now
  end

  # GET /banner_videos/1/edit
  def edit
  end

  # POST /banner_videos
  # POST /banner_videos.json
  def create
    @banner_video = BannerVideo.new(banner_video_params)
    exchange_attributes_params
    respond_to do |format|
      if @banner_video.save
        @banner_video.campaign.update_bidder if @banner_video.campaign
        notice = 'Video was successfully created.'       
        notice +=  ' <span class="text-danger">Error on bidder synch process. Please try again.</span>' if @banner_video.campaign and not @banner_video.campaign.update_bidder
        format.html { redirect_to @banner_video, notice: notice }
        format.json { render :show, status: :created, location: @banner_video }
      else
        format.html { render :new }
        format.json { render json: @banner_video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /banner_videos/1
  # PATCH/PUT /banner_videos/1.json
  def update
    respond_to do |format|
      old_campaign = @banner_video.campaign
      if @banner_video.update(banner_video_params)
        @banner_video.exchange_attributes.delete_all
        exchange_attributes_params
        notice = 'Video was successfully updated.' 
        # Update bidder for old and new campaign 
        if old_campaign and 
          ( 
            not @banner_video.campaign or                                     # campaign removed
            not @banner_video.campaign.id.to_s.eql?(old_campaign.id.to_s)     # campaign changed
          )
          then
            puts "Update previous campaign #{old_campaign.id.to_s}"
            old_campaign.update_bidder           
        end
        if @banner_video.campaign and not @banner_video.campaign.update_bidder 
            notice += ' <span class="text-danger">Error on bidder synch process. Please try again.</span>'
        end                  
        format.html { redirect_to @banner_video, notice: notice }
        format.json { render :show, status: :ok, location: @banner_video }
      else
        format.html { render :edit }
        format.json { render json: @banner_video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /banner_videos/1
  # DELETE /banner_videos/1.json
  def destroy
    old_campaign = @banner_video.campaign
    if not Bidder.ping
      notice = '<span class="text-danger">Error. Unable to connect to bidder. Check staus and try again.</span>'
    else
      if @banner_video.destroy
        notice = 'Video was successfully destroyed.' 
        old_campaign.update_bidder if old_campaign 
      else
        notice = '<span class="text-danger">Bidder updated but database error. Please try again.</span>'
      end
    end
    respond_to do |format|
      format.html { redirect_to banner_videos_url, notice: notice }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_banner_video
      @banner_video = BannerVideo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # hourly_budget missing from table????
    def banner_video_params
      if str = params[:interval_start] 
        params[:banner_video][:interval_start] = Time.strptime(str, "%m/%d/%Y %H:%M")     #"11/17/2016 1:37 PM"      
      end
      if str = params[:interval_end] 
        params[:banner_video][:interval_end] =  Time.strptime(str, "%m/%d/%Y %H:%M")  
      end

      if params[:size_match_type].eql?("none")
          params[:banner_video][:vast_video_height] = nil
          params[:banner_video][:vast_video_width] = nil
          params[:banner_video][:width_range] = nil
          params[:banner_video][:height_range] = nil
          params[:banner_video][:width_height_list] = nil          
      elsif params[:size_match_type].eql?("width_height_only")
          params[:banner_video][:width_range] = nil
          params[:banner_video][:height_range] = nil
          params[:banner_video][:width_height_list] = nil                  
      elsif params[:size_match_type].eql?("width_height_range")
          params[:banner_video][:vast_video_height] = nil
          params[:banner_video][:vast_video_width] = nil
          params[:banner_video][:width_range].gsub!(/\s/,"")
          params[:banner_video][:height_range].gsub!(/\s/,"")           
          params[:banner_video][:width_height_list] = nil                  
      elsif params[:size_match_type].eql?("width_height_list")
          params[:banner_video][:vast_video_height] = nil
          params[:banner_video][:vast_video_width] = nil
          params[:banner_video][:width_range] = nil
          params[:banner_video][:height_range] = nil
          params[:banner_video][:width_height_list].gsub!(/\s/,"") 
      end      


      # Convert deals to format id:price,id:price,....
      if params[:deal_type].eql?("none")
          params[:banner_video][:deals] = ""      
      elsif params[:deal_id] and params[:deal_price]
          # Create deals field
          dealsAry = []
          params[:deal_id].each_with_index do |id,index| 
              dealsAry.push("#{id}:#{params[:deal_price][index]}") if not id.to_s.empty? and params[:deal_price][index] 
          end
          if params[:deal_type].eql?("private_only")
              params[:banner_video][:bid_ecpm] = 0
          end
          params[:banner_video][:deals] = dealsAry.join(",")
      end

      params.require(:banner_video).permit(:campaign_id,:id,:name,:updated_at,:created_at,:interval_start, :interval_end,
        :total_basket_value, :daily_budget,:hourly_budget, :bid_ecpm, :contenttype, :iurl, :htmltemplate, :target_id, :vast_video_width, :vast_video_height,
        :width_range, :height_range, :width_height_list,
        :vast_video_linerarity,:vast_video_duration,:vast_video_type,:vast_video_outgoing_file, :frequency_spec,:frequency_expire,:frequency_count,
        :bitrate, :mime_type, :deals,
        :rtb_standard_ids=>[] )

    end

    def exchange_attributes_params
        if params[:exchange_attributes] and params[:exchange_attributes_exchange]
          params[:exchange_attributes].each do |exchg|
            exchg.each_with_index do |(name,val),idx|                
                @banner_video.exchange_attributes << ExchangeAttribute.create( 
                      name: name , 
                      value: val, 
                      exchange: params[:exchange_attributes_exchange][idx]
                ) if params[:exchange_attributes_exchange][idx]
            end
          end        
        end

    end


end

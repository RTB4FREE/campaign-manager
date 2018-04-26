class BannersController < ApplicationController
  before_action :set_banner, only: [:show, :edit, :update, :destroy]

  before_filter :authorize

  # GET /banners
  # GET /banners.json
  def index
    @banners = Banner.order(:name)
  end

  # GET /banners/1
  # GET /banners/1.json
  def show
  end

  # GET /banners/new
  def new
    @banner = Banner.new
    @banner.frequency_spec = "device.ip" if @banner.frequency_spec.to_s.empty?
    @banner.interval_start ||= Time.now
    @banner.interval_end ||= Time.now
  end

  # GET /banners/1/edit
  def edit
  end

  # POST /banners
  # POST /banners.json
  def create
    @banner = Banner.new(banner_params)
    exchange_attributes_params
    respond_to do |format|
      if @banner.save
        notice = 'Banner was successfully created.'       
        notice +=  ' <span class="text-danger">Error on bidder synch process. Please try again.</span>' if @banner.campaign and not @banner.campaign.update_bidder
        format.html { redirect_to @banner, notice: notice }
        format.json { render :show, status: :created, location: @banner }
      else
        format.html { render :new }
        format.json { render json: @banner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /banners/1
  # PATCH/PUT /banners/1.json
  def update
    respond_to do |format|
      old_campaign = @banner.campaign
      if @banner.update(banner_params)
        @banner.exchange_attributes.delete_all if @banner.exchange_attributes
        exchange_attributes_params
        notice = 'Banner was successfully updated.' 
        # Update bidder for old and new campaign 
        if old_campaign and 
          ( 
            not @banner.campaign or                                     # campaign removed
            not @banner.campaign.id.to_s.eql?(old_campaign.id.to_s)     # campaign changed
          )
          then
            puts "Update previous campaign #{old_campaign.id.to_s}"
            old_campaign.update_bidder           
        end
        if @banner.campaign and not @banner.campaign.update_bidder 
            notice += ' <span class="text-danger">Error on bidder synch process. Please try again.</span>'
        end        
        format.html { redirect_to @banner, notice: notice }
        format.json { render :show, status: :ok, location: @banner }
      else
        format.html { render :edit }
        format.json { render json: @banner.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /banners/1
  # DELETE /banners/1.json
  def destroy
    old_campaign = @banner.campaign
    notice = ""
    if not Bidder.ping
      notice = '<span class="text-danger">Error. Unable to connect to bidder. Check staus and try again.</span>'
    else
      if @banner.destroy
        notice = 'Banner was successfully destroyed.' 
        old_campaign.update_bidder  if old_campaign
      else
        notice = '<span class="text-danger">Bidder updated but database error. Please try again.</span>'
      end
    end
    respond_to do |format|
      format.html { redirect_to banners_url, notice: notice }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_banner
      @banner = Banner.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def banner_params
      
      # Convert datepicker strings to time objects
      if str = params[:interval_start] 
        params[:banner][:interval_start] = Time.strptime(str, "%m/%d/%Y %H:%M")     #"11/17/2016 1:37 PM"      
      end
      if str = params[:interval_end] 
        params[:banner][:interval_end] =  Time.strptime(str, "%m/%d/%Y %H:%M")  
      end
      
      if params[:size_match_type].eql?("none")
          params[:banner][:height] = nil
          params[:banner][:width] = nil
          params[:banner][:width_range] = nil
          params[:banner][:height_range] = nil
          params[:banner][:width_height_list] = nil          
      elsif params[:size_match_type].eql?("width_height_only")
          params[:banner][:width_range] = nil
          params[:banner][:height_range] = nil
          params[:banner][:width_height_list] = nil         
      elsif params[:size_match_type].eql?("width_height_range")
          params[:banner][:height] = nil
          params[:banner][:width] = nil
          params[:banner][:width_range].gsub!(/\s/,"")
          params[:banner][:height_range].gsub!(/\s/,"")           
          params[:banner][:width_height_list] = nil                  
      elsif params[:size_match_type].eql?("width_height_list")
          params[:banner][:height] = nil
          params[:banner][:width] = nil
          params[:banner][:width_range] = nil
          params[:banner][:height_range] = nil
          params[:banner][:width_height_list].gsub!(/\s/,"")           
      end      
      
      # Convert deals to format id:price,id:price,....
      if params[:deal_type].eql?("none")
          params[:banner][:deals] = ""      
      elsif params[:deal_id] and params[:deal_price]
          # Create deals field
          dealsAry = []
          params[:deal_id].each_with_index do |id,index| 
              dealsAry.push("#{id}:#{params[:deal_price][index]}") if not id.to_s.empty? and params[:deal_price][index] 
          end
          if params[:deal_type].eql?("private_only")
              params[:banner][:bid_ecpm] = 0
          end
          params[:banner][:deals] = dealsAry.join(",")
      end
      
      params.require(:banner).permit(:campaign_id,:id, :name, :updated_at,:created_at,:interval_start, :interval_end,
        :total_basket_value, :daily_budget,:hourly_budget, :bid_ecpm, :contenttype, :iurl, :htmltemplate, :targetting, :width, :height, 
        :width_range, :height_range, :width_height_list,
        :frequency_spec,:frequency_expire,:frequency_count ,:target_id, :deals, :rtb_standard_ids=>[])
    end


    def exchange_attributes_params
        if params[:exchange_attributes] and params[:exchange_attributes_exchange]
          params[:exchange_attributes].each do |exchg|
            exchg.each_with_index do |(name,val),idx|                
                @banner.exchange_attributes << ExchangeAttribute.create( 
                      name: name , 
                      value: val, 
                      exchange: params[:exchange_attributes_exchange][idx]
                ) if params[:exchange_attributes_exchange][idx]
            end
          end        
        end

    end

end

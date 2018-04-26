class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]
  before_filter :authorize
  
  # GET /campaigns
  # GET /campaigns.json
  def index
    @campaigns = Campaign.order(:name)
  end

  # GET /campaigns/1
  # GET /campaigns/1.json
  def show
  end

  # GET /campaigns/new
  def new
    @campaign = Campaign.new
    # Set initial defaults
    @campaign.status = "offline" 
    @campaign.forensiq = "no" 
    @campaign.activate_time ||= Time.now
    @campaign.expire_time ||= Time.now
  end

  # GET /campaigns/1/edit
  def edit
  end

  # POST /campaigns
  # POST /campaigns.json
  def create
    @campaign = Campaign.new(campaign_params)
    respond_to do |format|
      if @campaign.save 
        notice = 'Campaign was successfully created.'         
        notice +=  ' <span class="text-danger">Error on bidder synch process. Please try again.</span>'  if not @campaign.update_bidder
        format.html { redirect_to @campaign, notice: notice }
        format.json { render :show, status: :created, location: @campaign }
      else
        format.html { render :new }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campaigns/1
  # PATCH/PUT /campaigns/1.json
  def update
    respond_to do |format|
      if @campaign.update(campaign_params)
        notice = 'Campaign was successfully updated.' 
        notice += ' <span class="text-danger">Error on bidder synch process. Please try again.</span>'  if not @campaign.update_bidder
        format.html { redirect_to @campaign,  notice: notice }
        format.json { render :show, status: :ok, location: @campaign }
      else
        format.html { render :edit }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.json
  def destroy
      if @campaign.remove_bidder and @campaign.destroy
          notice = 'Campaign was successfully destroyed.' 
      else
          notice =  '<span class="text-danger">Error connecting to database or bidders. Please try again.</span>' 
      end
      respond_to do |format|       
        format.html { redirect_to campaigns_url, notice: notice }
        format.json { head :no_content }
      end
  end

  def getDates
      if @campaign = Campaign.find(params[:id])
        resp = { start: @campaign.activate_time.strftime("%m/%d/%Y %H:%M") , end: @campaign.expire_time.strftime("%m/%d/%Y %H:%M") }
      else
        resp = { error: true }
      end
      puts "Returning #{resp.to_json}"
      render layout: false, text: resp.to_json        
    end

  def getExchangeAttributes
      attrObj = {}
      if camp= Campaign.find(params[:id]) and 
          not camp.exchanges.to_s.empty? and
          exchanges=camp.exchanges.split(",") 
      then    
            exchanges.each do |exchg|                 
                attrHash = {}
                attrObj[exchg] = attrHash 
            end
      end  
      puts "Returning attrObj #{attrObj}"
      render :partial => "banners/exchange_attributes", :content_type => "text/html", :locals => { :attrObj => attrObj }
  end
  
  def biddersSynchAll
      resp = {}
      if Bidder.updateAll
        resp = { status:"OK" }
      else
        resp = { status: "error" }
      end
      puts "Returning #{resp.to_json}"
      render layout: false, text: resp.to_json            
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end


    def campaign_params
    # Translate param arrays to comma separated strings
      if str = params[:activate_time] 
        params[:campaign][:activate_time] = Time.strptime(str, "%m/%d/%Y %H:%M")         
      end
      if str = params[:expire_time] 
        params[:campaign][:expire_time] =  Time.strptime(str, "%m/%d/%Y %H:%M")  
      end

      ["exchanges","regions"].each do |attr|
        str = params[attr]
        str = str.join(",") if str.kind_of?(Array)
        params[:campaign][attr] = str.to_s
      end
      params.require(:campaign).permit(:name, :id, :activate_time, :expire_time, 
        :budget_limit_daily, :budget_limit_hourly, :total_budget, :ad_domain, :status, :shard, :forensiq, :deleted_at,
        :exchanges, :regions, :target_id, :rtb_standard_ids=>[] )
    end
end

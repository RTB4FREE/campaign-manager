class TargetsController < ApplicationController

  before_action :set_target, only: [:show, :edit, :update, :destroy]
  before_filter :authorize
  
  # GET /targets
  # GET /targets.json
  def index
    @targets = Target.order(:name)
  end

  # GET /targets/1
  # GET /targets/1.json
  def show
  end

  # GET /targets/new
  def new
    @target = Target.new
    @target.activate_time ||= Time.now
    @target.expire_time ||= Time.now
  end

  # GET /targets/1/edit
  def edit
  end

  # POST /targets
  # POST /targets.json
  def create
    @target = Target.new(target_params)
    respond_to do |format|
      if @target.save
        # No need to update campaigns. Targets are assigned in Campaign edit.
        format.html { redirect_to @target, notice: 'Target was successfully created.' }
        format.json { render :show, status: :created, location: @target }
      else
        format.html { render :new }
        format.json { render json: @target.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /targets/1
  # PATCH/PUT /targets/1.json
  def update
    respond_to do |format|
      old_camp_ids = @target.campaigns.collect{|c| c.id.to_s}      
      if @target.update(target_params)
        notice = 'Target was successfully updated.'
        new_camp_ids = @target.campaigns.collect{|c| c.id.to_s}      
        old_camp_ids ||= []
        new_camp_ids ||=[]
        new_camp_ids += old_camp_ids
        new_camp_ids.uniq!   # List all campaigns to update
        # Update bidder for old and new campaign 
        new_camp_ids.each do |id|              
            if campaign = Campaign.find_by_id(id) 
              puts "Update campaign #{id}"
              if not campaign.update_bidder
                notice += ' <span class="text-danger">Error on bidder synch process. Please try again.</span>'
                break
              end
            end
        end 
        format.html { redirect_to @target, notice: notice }
        format.json { render :show, status: :ok, location: @target }
      else
        format.html { render :edit }
        format.json { render json: @target.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /targets/1
  # DELETE /targets/1.json
  def destroy
    old_campaigns = @target.campaigns 
    notice = ""
    if not Bidder.ping
      notice = '<span class="text-danger">Error. Unable to connect to bidder. Check staus and try again.</span>'
    else  
      if @target.destroy
        notice += 'Target was successfully destroyed.'
        old_campaigns.each do |c| 
            c.update_bidder 
        end if old_campaigns 
      else
        notice += '<span class="text-danger">Database error. Please try again.</span>'  
      end
    end
    respond_to do |format|
      format.html { redirect_to targets_url, notice: notice  }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_target
      @target = Target.find(params[:id])
    end


    def target_params
      # translate datetimepicker
      if str = params[:activate_time] 
        params[:target][:activate_time] = Time.strptime(str, "%m/%d/%Y %H:%M")       
      end
      if str = params[:expire_time] 
        params[:target][:expire_time] =  Time.strptime(str, "%m/%d/%Y %H:%M")  
      end
      if params[:target] and list=params[:target][:list_of_domains]
          params[:target][:list_of_domains] = list.to_s.split(/\s+/).join(",")
      end      
    # Translate param arrays to comma separated strings
      ["country","devicetype","IAB_category","IAB_category_blklist"].each do |attr|
        str = params[attr]
        str = str.join(",") if str.kind_of?(Array)
        params[:target][attr] = str.to_s
      end
      if params[:target] and not params[:target][:domains_list_id].to_s.empty? and list=List.find_by_id(params[:target][:domains_list_id])        
        params[:target][:list_of_domains] = "$#{list.name}"
      end
      params.require(:target).permit(:name, :id, :activate_time, :expire_time, :list_of_domains, :domains_list_id,
        :domain_targetting, :geo_latitude,:geo_longitude, :geo_range, :country, :geo_region, :carrier, :os, :make, :model,
        :devicetype,:IAB_category,:IAB_category_blklist,:created_at, :updated_at )
    end





end

class RtbStandardsController < ApplicationController

  before_action :set_rtb_standard, only: [:show, :edit, :update, :destroy]
  before_filter :authorize
  
  # GET /rtb_standards
  # GET /rtb_standards.json
  def index
    @rtb_standards = RtbStandard.order(:name)
  end

  # GET /rtb_standards/1
  # GET /rtb_standards/1.json
  def show
  end

  # GET /rtb_standards/new
  def new
    @rtb_standard = RtbStandard.new
    @rtb_standard.rtb_required ||= true
  end

  # GET /rtb_standards/1/edit
  def edit
  end

  # POST /rtb_standards
  # POST /rtb_standards.json
  def create
    @rtb_standard = RtbStandard.new(rtb_standard_params)
    respond_to do |format|
      if @rtb_standard.save
        # No need to update campaigns. Targets are assigned in Campaign edit.
        format.html { redirect_to @rtb_standard, notice: 'Rule was successfully created.' }
        format.json { render :show, status: :created, location: @rtb_standard }
      else
        format.html { render :new }
        format.json { render json: @rtb_standard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rtb_standards/1
  # PATCH/PUT /rtb_standards/1.json
  def update
    respond_to do |format|
      old_camp_ids = []
      old_camp_ids += @rtb_standard.campaigns.collect{|c| c.id.to_s} if @rtb_standard.campaigns
      old_camp_ids += @rtb_standard.banners.collect{|b| b.campaign.id.to_s } if @rtb_standard.banners
      old_camp_ids += @rtb_standard.banner_videos.collect{|c| c.campaign.id.to_s } if @rtb_standard.banner_videos
      puts "Old campaigns #{old_camp_ids}"
      if @rtb_standard.update(rtb_standard_params)
        notice = 'Rule was successfully updated.'
        new_camp_ids =[]
        new_camp_ids += @rtb_standard.campaigns.collect{|c| c.id.to_s} if @rtb_standard.campaigns
        new_camp_ids += @rtb_standard.banners.collect{|b| b.campaign.id.to_s } if @rtb_standard.banners
        new_camp_ids += @rtb_standard.banner_videos.collect{|c| c.campaign.id.to_s } if @rtb_standard.banner_videos
        puts "New campaigns #{old_camp_ids}"
        new_camp_ids += old_camp_ids
        new_camp_ids.uniq!   # List all campaigns to update
        # Update bidder for old and new campaign 
        new_camp_ids.each do |id|              
            if id and campaign = Campaign.find_by_id(id) 
              puts "Update campaign #{id}, name #{campaign.name}"
              if not campaign.update_bidder
                notice += ' <span class="text-danger">Error on bidder synch process. Please try again.</span>'
                break
              end
            else 
              puts "Can't find campaign #{id}"
            end
        end                 
        format.html { redirect_to @rtb_standard, notice: notice }
        format.json { render :show, status: :ok, location: @rtb_standard }
      else
        format.html { render :edit }
        format.json { render json: @rtb_standard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rtb_standards/1
  # DELETE /rtb_standards/1.json
  def destroy
    notice = ""
    if not Bidder.ping
      notice = '<span class="text-danger">Error. Unable to connect to bidder. Check staus and try again.</span>'
    else  
        old_camp_ids = []
        old_camp_ids += @rtb_standard.campaigns.collect{|c| c.id.to_s} if @rtb_standard.campaigns
        old_camp_ids += @rtb_standard.banners.collect{|b| b.campaign.id.to_s } if @rtb_standard.banners
        old_camp_ids += @rtb_standard.banner_videos.collect{|c| c.campaign.id.to_s } if @rtb_standard.banner_videos
        puts "Old campaigns #{old_camp_ids}"
        old_camp_ids.uniq!   # List all campaigns to update
      if @rtb_standard.destroy
        notice += 'Rule was successfully destroyed.'
        # Update bidder for old and new campaign 
        old_camp_ids.each do |id|              
            if id and campaign = Campaign.find_by_id(id) 
              puts "Update campaign #{id}, name #{campaign.name}"
              campaign.update_bidder
            else 
              puts "Can't find campaign #{id}"
            end
        end
      else
        notice += '<span class="text-danger">Database error. Please try again.</span>'  
      end
    end
    respond_to do |format|
      format.html { redirect_to rtb_standards_url, notice: notice }
      format.json { head :no_content }
    end
  end

    def duplicate
        @rtb_standard = RtbStandard.find(params[:id]).dup
        @rtb_standard.name = "#{@rtb_standard.name} Copy"
        respond_to do |format|
            if @rtb_standard.save
                format.html { redirect_to rtb_standards_path, notice: 'Rule was successfully duplicated.' }
                format.json { render :edit, status: :created, location: @rtb_standard }
            else
                format.html { render :new }
                format.json { render json:@rtb_standard.errors, status: :unprocessable_entity }
            end
        end        
        
    end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rtb_standard
      @rtb_standard = RtbStandard.find(params[:id])
    end


    def rtb_standard_params
      
      # Check if a list is referenced
      if params[:rtb_standard] and not params[:rtb_standard][:operand_list_id].to_s.empty? and list=List.find_by_id(params[:rtb_standard][:operand_list_id])        
        params[:rtb_standard][:operand] = "$#{list.name}"
      end
      
      params.require(:rtb_standard).permit(:rtbspecification,:name, :description, :operator, :operand, :operand_type, :operand_list_id,
        :operand_ordinal, :rtb_required, :created_at, :updated_at )
    end





end

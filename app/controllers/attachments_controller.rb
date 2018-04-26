class AttachmentsController < ApplicationController

    def show
        @attachment = Attachment.find(params[:id])
        send_data @attachment.data, :filename => @attachment.filename, :type => @attachment.content_type
    end

  def index
    @attachments = Attachment.order(:filename)
  end


    def create
        return if params[:attachment].blank?
        @attachment = Attachment.new
        @attachment.uploaded_file = params[:attachment]
        
        # Disable logging of blob
        old_logger = ActiveRecord::Base.logger
        ActiveRecord::Base.logger = nil
        
        if @attachment.save
            ActiveRecord::Base.logger = old_logger
            flash[:notice] = "File uploaded."
            redirect_to :action => "index"
        else
            ActiveRecord::Base.logger = old_logger
            flash[:error] = "There was a problem uploading your file."
            render :action => "new"
        end
        
    end

end
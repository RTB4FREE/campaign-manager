class DocumentsController < ApplicationController

    before_action :set_document, only: [:show, :edit, :update, :destroy ]

	before_filter :authorize


    def index
        @documents = Document.order(:name)
    end

    def show
    end

    def new
        @document = Document.new
    end

    def edit
    end

    def create
        @document = Document.new(document_params)
        respond_to do |format|
            if @document.save
                format.html { redirect_to edit_document_path(@document), notice: 'Document was successfully created.' }
                format.json { render :edit, status: :created, location: @document }
            else
                format.html { render :new }
                format.json { render json: @document.errors, status: :unprocessable_entity }
            end
        end
    end

    def duplicate
        @document = Document.find(params[:id]).dup
        @document.name = "#{@document.name} Copy"
        respond_to do |format|
            if @document.save
                format.html { redirect_to documents_path, notice: 'Document was successfully duplicated.' }
                format.json { render :edit, status: :created, location: @document }
            else
                format.html { render :new }
                format.json { render json:@document.errors, status: :unprocessable_entity }
            end
        end        
        
    end

    def update
        respond_to do |format|
            if @document.update(document_params)
                format.html { redirect_to edit_document_path(@document), notice: 'Document was successfully updated.' }
                format.json { render :show, status: :ok, location: @document }
            else
                format.html { render :edit }
                format.json { render json: @document.errors, status: :unprocessable_entity }
            end
        end
    end


    def destroy
        @document.destroy
        respond_to do |format|
            format.html { redirect_to documents_path, notice: 'Document was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

	def copyOneList
		obj = TapScript.new();		
		if id = params["submit"] then 			
			if newDoc = obj.copyOne(id,current_user.id.to_s) then 
				obj.add(newDoc);		
			end
		end
		list	
		render "list"
	end


	def save
		params.each { |k,v| puts "#{k}=#{v}"  }
		newDoc = {
			:name=>params[:name],
			:description=>params[:description],
			:user_ref => current_user.id.to_s,
			:type=>params[:type],
			:code=>params[:code],
		}
		obj = TapScript.new();
		obj.update(params[:id],newDoc) ;
		list
		render "list"
	end




    private

    def set_document
        @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:name, :updated_at,:created_at,:description, :doctype,
        :code, :category_ids=>[])
    end





end


__END__


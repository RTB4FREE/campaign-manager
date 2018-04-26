class HelpController < ApplicationController


	before_filter :authorize

	def open
	    puts "params: #{params.inspect}"
	    @document = Document.find(params[:id])
	end


	def list	
		if params[:sort] and params[:sort].eql?("category") 
			@categories = Category.order(:name)
			@sort = "category"
		else			
			@documents = Document.order(:name)
			@sort = "document"
		end
	end


end


__END__


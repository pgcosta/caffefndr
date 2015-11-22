class WelcomeController < ApplicationController
	def index
		if params[:postcode].present?
			postcode_service = PostCodeService.new(params[:postcode])

			if postcode_service.valid?
				postal_code = postcode_service.get_postal_code_object
				@list = postal_code.caffes
				render 'list'
			end
		end
	end
end

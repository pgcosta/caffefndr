class WelcomeController < ApplicationController
	def index
		if params[:postcode].present?
			postcode_service = PostCodeService.new(params[:postcode])

			if postcode_service.valid?
				@postal_code = postcode_service.get_postal_code_object
				@list = @postal_code.caffes
				if params[:sort_by] == "popularity"
					@list = @list.order :popularity => :desc
				else
					@list = @list.order :name => :asc
				end
				gon.points = @postal_code.gmaps_points_of_caffes
				
				render 'postal_codes' and return
			else
				redirect_to(root_url, notice: "Postcode not valid. Try another one!")
			end
		end
	end
end

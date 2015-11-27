class PostalCodesController < ApplicationController
  def show
    if params[:postcode].present?
      postcode_service = PostCodeService.new(params[:postcode])

      if postcode_service.valid?
        @postal_code = postcode_service.get_postal_code_object
        @list = @postal_code.caffes
        gon.points = @postal_code.gmaps_points_of_caffes
        
        render 'show'
      end
    end
  end
end

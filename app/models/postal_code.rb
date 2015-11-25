class PostalCode < ActiveRecord::Base
	validates :postal_code, uniqueness: true
	
	has_and_belongs_to_many :caffes

  def gmaps_points_of_caffes
    self.caffes.inject([]) do |res, caffe|
      res << [caffe.name, caffe.lat, caffe.lon]
    end
  end
end

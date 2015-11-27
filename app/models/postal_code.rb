class PostalCode < ActiveRecord::Base
  
	validates :postal_code, uniqueness: true
	
	has_and_belongs_to_many :caffes

  before_create :set_searches_count

  def gmaps_points_of_caffes
    self.caffes.inject([]) do |res, caffe|
      res << [caffe.name, caffe.lat, caffe.lon]
    end
  end

  private

  def set_searches_count
    self.searches_count = 0
  end
end

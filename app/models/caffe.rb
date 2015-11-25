class Caffe < ActiveRecord::Base

	validates :foursquare_id, uniqueness: true

	has_and_belongs_to_many :postal_codes

  before_save :generate_popularity_ranking

	def self.build_from_hashie hashie
		caffe = Caffe.find_by_foursquare_id hashie.id
		caffe ||= Caffe.new
    
    caffe.update_attributes!(
			name: hashie.name,
      twitter: hashie.contact.twitter,
      address: hashie.location.address,
      city: hashie.location.city,
      checkins_count: hashie.stats.checkinsCount,
      users_count: hashie.stats.usersCount,
      foursquare_id: hashie.id,
      lat: hashie.location.lat,
      lon: hashie.location.lng,
      tip_count: hashie.stats.tipCount
		)
    caffe
	end

  private

  def generate_popularity_ranking
    popularity = 0
    # does the caffe has a lot of returning customers?
    popularity = 
    if users_count > 30
      ratio = min(checkins_count,users_count)/max(checkins_count,users_count).to_f
      100*(ratio)
    else
      10
    end

    popularity += popularity<10.0 ? 10.0 : 0.0

    # is the ratio tips / checkins greater than 0.23?
    #  if so let's take those into account
    if tip_count/checkins_count.to_f > 0.23
      popularity += (tip_count/users_count.to_f)*100
    end
    
    self.popularity = popularity > 100 ? 100 : popularity.to_i
  end

  def max(a,b)
    a>b ? a : b
  end

  def min(a,b)
    a<b ? a : b
  end
end

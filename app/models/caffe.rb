class Caffe < ActiveRecord::Base

	validates :foursquare_id, uniqueness: true

	has_and_belongs_to_many :postal_codes

	def self.build_from_hashie hashie
		cafe = Caffe.find_by_foursquare_id hashie.id

		caffe ||= Caffe.create!(
			name: hashie.name,
      twitter: hashie.contact.twitter,
      address: hashie.location.address,
      city: hashie.location.city,
      checkins_count: hashie.stats.checkinsCount,
      users_count: hashie.stats.usersCount,
      foursquare_id: hashie.id
		)
	end
end

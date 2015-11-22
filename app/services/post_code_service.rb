require "net/http"
require "uri"

class PostCodeService

	# Make a get request to the postcodes API
	#  get the info about the post_code
	def initialize post_code
		url_with_post_code = URI.escape("http://api.postcodes.io/postcodes/" + post_code)
		uri = URI.parse(url_with_post_code)
		# Shortcut
		response = Net::HTTP.get_response(uri)

		@post_code_data = JSON.parse(response.body)
	end

	# Returns a PostalCode object
	#  either get's it from the database or creates a new one
	def get_postal_code_object
		postal_code = PostalCode.find_by_postal_code(@post_code_data["result"]["postcode"])
		postal_code ||= create_new_postal_code
		postal_code
	end

	def valid?
		@post_code_data["status"] == 200
	end

	private

	# Create a PostalCode object from with the information got from:
	#  1. the postcodes API
	#  2. the foursquare API
	def create_new_postal_code
		postal_code = PostalCode.create!(
			lat: @post_code_data["result"]["latitude"].to_s,
    	long: @post_code_data["result"]["longitude"].to_s,
      postal_code: @post_code_data["result"]["postcode"])

		postal_code.caffes = get_caffes_array
		postal_code
	end

	# Returns an array of type Caffe from the foursquare API
	def get_caffes_array
		foursquare_caffes_array = caffes_list

		foursquare_caffes_array.inject([]) do |array, object|
			array << Caffe.build_from_hashie(object)
		end
	end

	# Returns a string in the format 'xx.xxxx,yy.yyyy'
	def coordinates
		latitude = @post_code_data["result"]["latitude"].to_s
		longitude = @post_code_data["result"]["longitude"].to_s
		latitude << ',' << longitude
	end

	# Returns an array of venues from the fourquare API
	#  venues is a Hashie object
	def caffes_list
		client = Foursquare2::Client.new(
			:client_id => FOURSQUARE_SETITINGS['client_id'],
			:client_secret => FOURSQUARE_SETITINGS['client_secret'])

		# raises Foursquare2::APIError if error
		response = client.search_venues(
			ll: coordinates,
			categoryId: '4bf58dd8d48988d1e0931735',
			radius: '500',
			v: '20150101'
		)

		response.venues
	end
end
class PostalCode < ActiveRecord::Base
	validates :postal_code, uniqueness: true
	
	has_and_belongs_to_many :caffes
end

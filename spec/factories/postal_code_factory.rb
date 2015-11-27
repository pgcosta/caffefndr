FactoryGirl.define do
  factory :postal_code do
    lat Faker::Address.latitude
    long Faker::Address.longitude
    sequence :postal_code do |n|
      "N1 AA#{n}"
    end
    searches_count 0
    foursquare_timeout Time.now
  end
end
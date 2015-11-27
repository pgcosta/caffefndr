FactoryGirl.define do
  factory :caffe do
    sequence :foursquare_id do |n|
      "7a8s47yiuch#{n}"
    end
    name Faker::Company.name
    twitter Faker::Internet.domain_word
    address Faker::Address.street_address
    city Faker::Address.city
    checkins_count 40
    users_count 40
    tip_count 30
    lat Faker::Address.latitude
    lon Faker::Address.longitude
  end
end
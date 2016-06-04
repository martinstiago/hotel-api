FactoryGirl.define do
  factory :hotel do
    name { Faker::Lorem.sentence }
    address { Faker::Address.street_address }
    star_rating { Faker::Number.between(1, 5) }
    accomodation_type
  end
end

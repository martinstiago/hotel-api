FactoryGirl.define do
  factory :accomodation_type do
    name { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
  end
end

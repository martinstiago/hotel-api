class HotelSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :star_rating
  belongs_to :accomodation_type
end

class HotelSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :star_rating, :accomodation_type

  def accomodation_type
    object.accomodation_type.name
  end
end

class HotelSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :star_rating, :accomodation_type

  def accomodation_type
    AccomodationTypeSerializer.new(object.accomodation_type)
  end
end

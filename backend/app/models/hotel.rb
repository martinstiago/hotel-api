class Hotel < ApplicationRecord
  belongs_to :accomodation_type

  validates :name, :address, :star_rating, :accomodation_type, presence: true
end

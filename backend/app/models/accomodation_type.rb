class AccomodationType < ApplicationRecord
  has_many :hotels

  validates :name, :description, presence: true
end

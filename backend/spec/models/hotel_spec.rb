require 'rails_helper'

describe Hotel, type: :model do
  context 'relationships' do
    it { is_expected.to belong_to(:accomodation_type) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:star_rating) }
    it { is_expected.to validate_presence_of(:accomodation_type) }
  end
end

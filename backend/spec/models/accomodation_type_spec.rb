require 'rails_helper'

describe AccomodationType, type: :model do
  context 'relationships' do
    it { is_expected.to have_many(:hotels) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
  end
end

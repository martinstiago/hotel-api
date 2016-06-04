require 'rails_helper'

RSpec.describe Hotel, type: :model do
  it { is_expected.to belong_to(:accomodation_type) }
end

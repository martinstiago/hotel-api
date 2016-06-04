require 'rails_helper'

RSpec.describe AccomodationType, type: :model do
  it { is_expected.to have_many(:hotels) }
end

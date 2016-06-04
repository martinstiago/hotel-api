require 'rails_helper'

describe AccomodationTypesController, type: :controller do
  describe '#index' do
    let!(:accomodation_types) { create_list :accomodation_type, 5 }

    it 'returns a list of accomodation types' do
      get :index

      expect(response.status).to eq(200)

      json = JSON.parse(response.body)
      expect(json).to be_a(Array)
      expect(json.count).to eq(5)

      json.each_with_index do |value, index|
        expect(value['id']).to eq(accomodation_types[index].id)
        expect(value['name']).to eq(accomodation_types[index].name)
      end
    end
  end
end

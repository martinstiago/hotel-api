require 'rails_helper'

describe HotelsController, type: :controller do
  describe '#index' do
    context 'basic request' do
      let!(:hotels) { create_list :hotel, 5 }

      it 'returns all hotels' do
        get :index

        expect(response.status).to eq(200)

        json = JSON.parse(response.body)
        expect(json).to be_a(Array)
        expect(json.count).to eq(5)

        json.each_with_index do |value, index|
          expect(value['id']).to eq(hotels[index].id)
          expect(value['name']).to eq(hotels[index].name)
          expect(value['address']).to eq(hotels[index].address)
          expect(value['star_rating']).to eq(hotels[index].star_rating)
          expect(value['accomodation_type'])
            .to eq(hotels[index].accomodation_type.name)
        end
      end
    end

    context 'searching' do
      let!(:hotel_1) { create :hotel, name: 'Testing', address: 'foo' }
      let!(:hotel_2) { create :hotel, name: 'bar', address: 'Testing' }
      let!(:hotel_3) { create :hotel, name: 'Canad Inns', address: '29 Dysart Road' }

      it 'searchs the query param on the name and address fields of the model' do
        get :index, params: { search: 'Testing' }

        expect(response.status).to eq(200)

        json = JSON.parse(response.body)
        expect(json).to be_a(Array)
        expect(json.count).to eq(2)

        expect(json.pluck('id')).to match_array([hotel_1.id, hotel_2.id])
      end

      it 'searchs for parts of the name and address fields of the model' do
        get :index, params: { search: 'Testi' }

        expect(response.status).to eq(200)

        json = JSON.parse(response.body)
        expect(json).to be_a(Array)
        expect(json.count).to eq(2)

        expect(json.pluck('id')).to match_array([hotel_1.id, hotel_2.id])
      end

      it 'does not have a case sensitive search' do
        get :index, params: { search: 'testing' }

        expect(response.status).to eq(200)

        json = JSON.parse(response.body)
        expect(json).to be_a(Array)
        expect(json.count).to eq(2)

        expect(json.pluck('id')).to match_array([hotel_1.id, hotel_2.id])
      end
    end
  end

  describe '#create' do
    let(:accomodation_type) { create :accomodation_type }

    context 'with valid parameters' do
      let(:values) do
        {
          name: 'Canad Inns',
          address: '29 Dysart Road',
          star_rating: 4,
          accomodation_type_id: accomodation_type.id
        }
      end

      it 'creates a new hotel' do
        post :create, params: { hotel: values }

        expect(response.status).to eq(201)

        json = JSON.parse(response.body)
        expect(json).to be_a(Hash)
        expect(json.keys)
          .to eq(%w(id name address star_rating accomodation_type))

        expect(json['name']).to eq(values[:name])
        expect(json['address']).to eq(values[:address])
        expect(json['star_rating']).to eq(values[:star_rating])
        expect(json['accomodation_type']).to eq(accomodation_type.name)
      end
    end

    context 'with invalid parameters' do
      let(:values) do
        {
          name: nil,
          address: '29 Dysart Road',
          star_rating: nil,
          accomodation_type_id: accomodation_type.id
        }
      end

      it 'returns the request errors' do
        post :create, params: { hotel: values }

        expect(response.status).to eq(422)

        json = JSON.parse(response.body)
        expect(json).to be_a(Hash)
        expect(json.keys).to eq(%w(name star_rating))

        expect(json['name']).to eq(["can't be blank"])
        expect(json['star_rating']).to eq(["can't be blank"])
      end
    end
  end

  describe '#show' do
    context 'with a valid id' do
      let(:hotel) { create :hotel }

      it 'returns the hotel model' do
        get :show, params: { id: hotel.id }

        expect(response.status).to eq(200)

        json = JSON.parse(response.body)
        expect(json).to be_a(Hash)
        expect(json.keys)
          .to eq(%w(id name address star_rating accomodation_type))

        expect(json['id']).to eq(hotel.id)
        expect(json['name']).to eq(hotel.name)
        expect(json['address']).to eq(hotel.address)
        expect(json['star_rating']).to eq(hotel.star_rating)
        expect(json['accomodation_type'].keys).to eq(%w(id name))
        expect(json['accomodation_type']['id']).to eq(hotel.accomodation_type.id)
        expect(json['accomodation_type']['name']).to eq(hotel.accomodation_type.name)
      end
    end

    context 'with an invalid id' do
      it 'returns an error' do
        get :show, params: { id: 999 }

        expect(response.status).to eq(404)
        json = JSON.parse(response.body)
        expect(json['error']).to eq("Couldn't find Hotel with 'id'=999")
      end
    end
  end

  describe '#update' do
    let(:hotel) { create :hotel }
    let(:accomodation_type) { create :accomodation_type }

    context 'with valid parameters' do
      let(:values) do
        {
          name: 'Canad Inns',
          address: '29 Dysart Road',
          star_rating: 4,
          accomodation_type_id: accomodation_type.id
        }
      end

      it 'updates the hotel values' do
        put :update, params: { id: hotel.id, hotel: values }

        expect(response.status).to eq(204)
      end
    end

    context 'with invalid parameters' do
      let(:values) do
        {
          name: nil,
          address: '29 Dysart Road',
          star_rating: nil,
          accomodation_type_id: accomodation_type.id
        }
      end

      it 'returns the request errors' do
        put :update, params: { id: hotel.id, hotel: values }

        expect(response.status).to eq(422)

        json = JSON.parse(response.body)
        expect(json).to be_a(Hash)
        expect(json.keys).to eq(%w(name star_rating))

        expect(json['name']).to eq(["can't be blank"])
        expect(json['star_rating']).to eq(["can't be blank"])
      end
    end
  end

  describe '#destroy' do
    context 'with a valid id' do
      let(:hotel) { create :hotel }

      it 'delete the hotel' do
        delete :destroy, params: { id: hotel.id }

        expect(response.status).to eq(204)
        expect(Hotel.find_by_id(hotel.id)).to be_nil
      end
    end

    context 'with an invalid id' do
      it 'returns an error' do
        delete :destroy, params: { id: 999 }

        expect(response.status).to eq(404)
        json = JSON.parse(response.body)
        expect(json['error']).to eq("Couldn't find Hotel with 'id'=999")
      end
    end
  end
end

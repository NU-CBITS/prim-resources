require 'rails_helper'

RSpec.describe 'address resource', type: :request do
  fixtures :all

  describe 'GET /v1/addresses' do
    it 'sends the addresses' do
      get '/v1/addresses', nil, @auth_header

      expect(response).to be_success
      expect(json.length).to eq Address.count
    end
  end

  describe 'GET /v1/addresses/:id' do
    context 'when the address is found' do
      let(:address_id) do
        addresses(:participant_123).id
      end

      it 'sends the address' do
        get "/v1/addresses/#{ address_id }", nil, @auth_header

        expect(response).to be_success
        expect(json['id']).to eq address_id
      end
    end
  end
end

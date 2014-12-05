require 'rails_helper'

RSpec.describe 'phone resource', type: :request do
  include_examples 'requests'

  fixtures :all

  describe 'GET /v1/phones' do
    it 'sends the phones' do
      get '/v1/phones', nil, all_project_auth_header

      expect(response).to be_success
      expect(json.length).to eq Phone.count
    end
  end

  describe 'GET /v1/phones/:id' do
    context 'when the phone is found' do
      let(:phone_id) do
        phones(:participant_123).id
      end

      it 'sends the phone' do
        get "/v1/phones/#{ phone_id }", nil, all_project_auth_header

        expect(response).to be_success
        expect(json['id']).to eq phone_id
      end
    end
  end
end

require 'rails_helper'

RSpec.describe 'status resource' do
  fixtures :all

  describe 'GET /v1/statuses' do
    it 'sends the statuses' do
      get '/v1/statuses'

      expect(response).to be_success
      expect(json.length).to eq Status.count
    end
  end

  describe 'GET /v1/statuses/:id' do
    context 'when the status is found' do
      let(:status_id) do
        statuses(:participant_123).id
      end

      it 'sends the status' do
        get "/v1/statuses/#{ status_id }"

        expect(response).to be_success
        expect(json['id']).to eq status_id
      end
    end
  end
end

require 'rails_helper'

RSpec.describe 'email resource' do
  fixtures :all

  describe 'GET /v1/emails' do
    it 'sends the emails' do
      get '/v1/emails'

      expect(response).to be_success
      expect(json.length).to eq Email.count
    end
  end

  describe 'GET /v1/emails/:id' do
    context 'when the email is found' do
      let(:email_id) do
        emails(:participant_123).id
      end

      it 'sends the email' do
        get "/v1/emails/#{ email_id }"

        expect(response).to be_success
        expect(json['id']).to eq email_id
      end
    end
  end
end

require 'rails_helper'

RSpec.describe 'email resource', type: :request do
  include_examples 'requests'

  fixtures :all

  describe 'GET /v1/emails' do
    it 'sends the emails' do
      get '/v1/emails', nil, all_project_auth_header

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
        get "/v1/emails/#{ email_id }", nil, all_project_auth_header

        expect(response).to be_success
        expect(json['id']).to eq email_id
      end
    end
  end
end

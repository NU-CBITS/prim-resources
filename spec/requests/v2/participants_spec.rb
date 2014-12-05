require 'rails_helper'

RSpec.describe 'Participants resource', type: :request do
  fixtures :all

  describe 'GET /v2/participants' do
    it 'sends the participants' do
      get '/v2/participants', nil, @auth_header

      expect(response).to be_success
      expect(json['participants'].length).to be Project.first.participants.count
    end
  end

  describe 'GET /v2/participants/:id' do
    context 'when the participant is found' do
      let(:participant) { Project.first.participants.first }

      it 'sends the participant' do
        get "/v2/participants/#{ participant.external_id }", nil, @auth_header

        expect(response).to be_success
        expect(json['participants']['id']).to eq participant.external_id
      end
    end

    context 'when the participant is not found' do
      it 'sends an error' do
        get '/v2/participants/baz', nil, @auth_header

        expect(response).to be_not_found
        expect(json['errors']).not_to be_nil
      end
    end
  end
end

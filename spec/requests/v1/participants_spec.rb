require 'rails_helper'

RSpec.describe 'participants resource' do
  fixtures :all

  describe 'GET /v1/participants' do
    it 'sends the participants' do
      get '/v1/participants'

      expect(response).to be_success
      expect(json.length).to eq Participant.count
    end
  end

  describe 'GET /v1/participants?external_id=:id' do
    context 'when the participant is found' do
      let(:participant_id) do
        participants(:participant_123).external_id
      end

      it 'sends the participant' do
        get "/v1/participants?external_id=#{ participant_id }"

        expect(response).to be_success
        expect(json.first['external_id']).to eq participant_id
      end
    end
  end
end

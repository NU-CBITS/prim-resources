require 'rails_helper'

RSpec.describe 'screening resource' do
  fixtures :all

  describe 'GET /v1/screenings' do
    it 'sends the screenings' do
      get '/v1/screenings'

      expect(response).to be_success
      expect(json.length).to eq Screening.count
    end
  end

  describe 'GET /v1/screenings/:id' do
    context 'when no participant_id is provided' do
      let(:screening_id) do
        screenings(:participant_123).id
      end

      it 'sends the screening' do
        get "/v1/screenings/#{ screening_id }"

        expect(response).to be_success
        expect(json.length).to eq Screening.count
      end
    end
  end
end

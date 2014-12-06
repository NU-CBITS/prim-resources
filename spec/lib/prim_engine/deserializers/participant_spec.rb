require 'rails_helper'

module PrimEngine
  module Deserializers
    RSpec.describe Participant do
      it 'sets default attributes' do
        params = ActionController::Parameters.new
        attrs = Participant.new(params).to_attrs

        expect(attrs[:addresses_attributes]).to eq []
        expect(attrs[:date_of_birth_attributes]).to eq({})
        expect(attrs[:education_level_attributes]).to eq({})
        expect(attrs[:emails_attributes]).to eq []
        expect(attrs[:ethnicity_attributes]).to eq({})
        expect(attrs[:gender_attributes]).to eq({})
        expect(attrs[:name_attributes]).to eq({})
        expect(attrs[:phones_attributes]).to eq []
        expect(attrs[:race_attributes]).to eq({})
      end

      it 'permits valid nested attributes' do
        params = ActionController::Parameters.new(
          participants: {
            addresses: [
              {
                street_2: 'street name',
                zip: 12345
              }
            ]
          }
        )
        attrs = Participant.new(params).to_attrs

        expect(attrs[:addresses_attributes][0][:street_2]).to eq 'street name'
        expect(attrs[:addresses_attributes][0][:zip]).to eq 12345
      end

      it 'rejects invalid nested attributes' do
        params = ActionController::Parameters.new(
          participants: {
            date_of_birth: { bazzle: 'asdf' }
          }
        )
        attrs = Participant.new(params).to_attrs

        expect(attrs[:date_of_birth_attributes][:bazzle]).to be_nil
      end
    end
  end
end

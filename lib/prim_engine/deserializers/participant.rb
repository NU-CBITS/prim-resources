module PrimEngine
  module Deserializers
    # Convert Participant request parameters into model attributes.
    class Participant
      def initialize(request_params)
        @request_params = request_params
      end

      def to_attrs
        attrs = @request_params.permit(
          participants: [
            { addresses: [:name, :street_1, :street_2, :city, :state, :zip,
                          :primary] },
            { date_of_birth: :date },
            { education_level: :value },
            { emails: [:email, :primary] },
            { ethnicity: :value },
            { gender: :value },
            { name: [:first_name, :last_name, :middle_name, :prefix, :suffix] },
            { phones: [:name, :number, :primary] },
            { race: :value },
            { consent_forms: [:expires_on, :study_number, :source] }
          ]
        )
        attrs = attrs[:participants] || {}

        {
          addresses_attributes: attrs[:addresses] || [],
          date_of_birth_attributes: attrs[:date_of_birth] || {},
          education_level_attributes: attrs[:education_level] || {},
          emails_attributes: attrs[:emails] || [],
          ethnicity_attributes: attrs[:ethnicity] || {},
          gender_attributes: attrs[:gender] || {},
          name_attributes: attrs[:name] || {},
          phones_attributes: attrs[:phones] || [],
          race_attributes: attrs[:race] || {},
          consent_forms_attributes: attrs[:consent_forms] || []
        }
      end
    end
  end
end

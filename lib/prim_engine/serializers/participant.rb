require 'active_model_serializers'

module PrimEngine
  module Serializers
    # Serialize Participant models.
    class Participant < ActiveModel::Serializer
      attributes :id

      has_many :addresses, serializer: PrimEngine::Serializers::Address
      has_many :phones, serializer: PrimEngine::Serializers::Phone
      has_many :emails, serializer: PrimEngine::Serializers::Email
      has_one :date_of_birth, serializer: PrimEngine::Serializers::DateOfBirth
      has_one :name, serializer: PrimEngine::Serializers::Name
      has_one :gender, serializer: PrimEngine::Serializers::Gender
      has_one :ethnicity, serializer: PrimEngine::Serializers::Ethnicity
      has_one :race, serializer: PrimEngine::Serializers::Race
      has_one :education_level,
              serializer: PrimEngine::Serializers::EducationLevel

      # look up :external_id on the model, use :id in the JSON
      def id
        object.external_id
      end
    end
  end
end

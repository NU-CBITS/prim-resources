require 'active_model_serializers'

module PrimEngine
  module Serializers
    # Serialize DateOfBirth models.
    class DateOfBirth < ActiveModel::Serializer
      attributes :date

      # look up :date_of_birth on the model, use :date in the JSON
      def date
        object.date_of_birth
      end
    end
  end
end

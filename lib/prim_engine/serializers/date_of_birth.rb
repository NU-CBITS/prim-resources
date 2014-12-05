require 'active_model_serializers'

module PrimEngine
  module Serializers
    # Serialize DateOfBirth models.
    class DateOfBirth < ActiveModel::Serializer
      attributes :date
    end
  end
end

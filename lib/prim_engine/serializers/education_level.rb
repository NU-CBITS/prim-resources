require 'active_model_serializers'

module PrimEngine
  module Serializers
    # Serialize Education Level models.
    class EducationLevel < ActiveModel::Serializer
      attributes :value
    end
  end
end

require 'active_model_serializers'

module PrimEngine
  module Serializers
    # Serialize Ethnicity models.
    class Ethnicity < ActiveModel::Serializer
      attributes :value
    end
  end
end

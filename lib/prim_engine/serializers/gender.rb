require 'active_model_serializers'

module PrimEngine
  module Serializers
    # Serialize Gender models.
    class Gender < ActiveModel::Serializer
      attributes :value
    end
  end
end

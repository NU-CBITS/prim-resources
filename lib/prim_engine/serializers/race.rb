require 'active_model_serializers'

module PrimEngine
  module Serializers
    # Serialize Race models.
    class Race < ActiveModel::Serializer
      attributes :value
    end
  end
end

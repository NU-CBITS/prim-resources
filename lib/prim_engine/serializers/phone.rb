require 'active_model_serializers'

module PrimEngine
  module Serializers
    # Serialize Phone models.
    class Phone < ActiveModel::Serializer
      attributes :name, :number, :primary
    end
  end
end

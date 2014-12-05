require 'active_model_serializers'

module PrimEngine
  module Serializers
    # Serialize Address models.
    class Address < ActiveModel::Serializer
      attributes :name, :street_1, :street_2, :city, :state, :zip, :primary
    end
  end
end

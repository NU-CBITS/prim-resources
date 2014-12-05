require 'active_model_serializers'

module PrimEngine
  module Serializers
    # Serialize Name models.
    class Name < ActiveModel::Serializer
      attributes :first_name, :last_name, :middle_name, :prefix, :suffix
    end
  end
end

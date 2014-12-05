require 'active_model_serializers'

module PrimEngine
  module Serializers
    # Serialize Email models.
    class Email < ActiveModel::Serializer
      attributes :email, :primary
    end
  end
end

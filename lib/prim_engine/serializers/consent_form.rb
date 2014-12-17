require 'active_model_serializers'

module PrimEngine
  module Serializers
    # Serialize ConsentForm models.
    class ConsentForm < ActiveModel::Serializer
      attributes :expires_on, :study_number, :source
    end
  end
end

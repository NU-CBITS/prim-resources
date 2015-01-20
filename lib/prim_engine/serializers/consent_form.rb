require 'active_model_serializers'

module PrimEngine
  module Serializers
    # Serialize ConsentForm models.
    class ConsentForm < ActiveModel::Serializer
      attributes :expires_on, :study_number, :source, :content, :signed_at,
                 :version
    end
  end
end

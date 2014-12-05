require 'active_model_serializers'

module PrimEngine
  module Serializers
    # Serialize Participant models.
    class Participant < ActiveModel::Serializer
      attributes :id

      # look up :external_id on the model, use :id in the JSON
      def id
        object.external_id
      end
    end
  end
end

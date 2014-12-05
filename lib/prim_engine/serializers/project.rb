require 'active_model_serializers'

module PrimEngine
  module Serializers
    # Serialize Project models.
    class Project < ActiveModel::Serializer
      attributes :id, :name

      has_many :participants,
               serializer: ParticipantShallow,
               embed_namespace: :links

      # look up :external_id on the model, use :id in the JSON
      def id
        object.external_id
      end
    end
  end
end

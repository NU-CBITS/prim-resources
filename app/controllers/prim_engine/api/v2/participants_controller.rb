require 'prim_engine'

module PrimEngine
  module Api
    module V2
      # Actions for Participant resources.
      class ParticipantsController < ApplicationController
        def index
          render json: scope_participants.select(:external_id),
                 each_serializer: PrimEngine::Serializers::Participant
        end

        def show
          if find_participant
            render json: @participant,
                   serializer: PrimEngine::Serializers::Participant,
                   root: 'participants'
          else
            render json: PrimEngine::ApiError.new(status: 'Not Found'),
                   serializer: PrimEngine::Serializers::ApiError,
                   root: 'errors',
                   status: :not_found
          end
        end

        private

        def find_participant
          @participant = scope_participants.find_by_external_id(params[:id])
        end

        # A consumer is either privy to all Participants, or to only those
        # in a particular Project.
        def scope_participants
          if current_consumer.project_id
            @participants = current_consumer.project.participants
          else
            @participants = Participant
          end
        end
      end
    end
  end
end

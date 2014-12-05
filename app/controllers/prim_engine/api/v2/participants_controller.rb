require 'prim_engine'

module PrimEngine
  module Api
    module V2
      # Actions for Participant resources.
      class ParticipantsController < ApplicationController
        def index
          render json: Participant.select(:external_id),
                 each_serializer: PrimEngine::Serializers::Participant
        end

        def show
          if find_participant
            render json: @participant,
                   serializer: PrimEngine::Serializers::Participant,
                   root: 'participants'
          else
            render json: PrimEngine::ApiError.new,
                   serializer: PrimEngine::Serializers::ApiError,
                   root: 'errors',
                   status: :not_found
          end
        end

        private

        def find_participant
          @participant = Participant.find_by_external_id(params[:id])
        end
      end
    end
  end
end

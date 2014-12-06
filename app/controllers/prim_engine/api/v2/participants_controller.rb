module PrimEngine
  module Api
    module V2
      # Actions for Participant resources.
      class ParticipantsController < ApplicationController
        def index
          render json: scope_participants
            .includes(:phones, :date_of_birth, :addresses, :emails, :name,
                      :gender, :ethnicity, :race)
            .select(:id, :external_id),
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

        def create
          if create_participant
            render json: @participant,
                   serializer: PrimEngine::Serializers::Participant,
                   root: 'participants',
                   status: 201
          else
            error = PrimEngine::ApiError.new(status: 'Bad Request',
                                             detail: errors_on(@participant))
            render json: error,
                   serializer: PrimEngine::Serializers::ApiError,
                   root: 'errors',
                   status: :bad_request
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

        def create_participant
          @participant = Participant.new(participant_params)

          begin
            if current_consumer.project_id
              current_consumer.project.participants << @participant
            else
              @participant.save!
            end

            true
          rescue
            false
          end
        end

        def participant_params
          @participant_params = params
                                .require(:participants)
                                .permit(date_of_birth: :date)
          @participant_params = {
            date_of_birth_attributes: @participant_params[:date_of_birth]
          }
        end

        def errors_on(resource)
          resource.errors.full_messages.join ', '
        end
      end
    end
  end
end

module PrimEngine
  module Api
    module V2
      # Actions for Participant resources.
      class ParticipantsController < ApplicationController
        def index
          render json: scope_participants
            .includes(:phones, :date_of_birth, :addresses, :education_level,
                      :emails, :name, :gender, :ethnicity, :race)
            .select(:id, :external_id),
                 each_serializer: PrimEngine::Serializers::Participant
        end

        def show
          if find_participant
            render json: @participant,
                   serializer: PrimEngine::Serializers::Participant,
                   root: 'participants'
          else
            render_not_found
          end
        end

        def create
          if create_participant
            # Serialization error (duplicate associations) without reload
            render json: @participant.reload,
                   serializer: PrimEngine::Serializers::Participant,
                   root: 'participants',
                   status: 201
          else
            render_bad_request
          end
        end

        def update
          if find_participant
            if @participant.update(participant_params)
              render json: @participant,
                     serializer: PrimEngine::Serializers::Participant,
                     root: 'participants',
                     status: 200
            else
              render_bad_request
            end
          else
            render_not_found
          end
        end

        private

        def find_participant
          @participant = scope_participants.find_by_external_id(params[:id])
        end

        # An API Consumer is either privy to all Participants, or to only those
        # in a particular Project.
        def scope_participants
          filter = PrimEngine::Filters::Participant.new(params)

          if current_consumer.project_id
            @participants = current_consumer.project.participants
          else
            @participants = Participant
          end

          filter.filter(@participants)
        end

        # A Participant is either created as a member of a Project or not
        # depending on the configuration of the API Consumer.
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
          PrimEngine::Deserializers::Participant.new(params).to_attrs
        end

        def errors_on(resource)
          resource.errors.full_messages.join ', '
        end

        def render_not_found
          render json: PrimEngine::ApiError.new(status: 'Not Found'),
                 serializer: PrimEngine::Serializers::ApiError,
                 root: 'errors',
                 status: :not_found
        end

        def render_bad_request
          error = PrimEngine::ApiError.new(status: 'Bad Request',
                                           detail: errors_on(@participant))
          render json: error,
                 serializer: PrimEngine::Serializers::ApiError,
                 root: 'errors',
                 status: :bad_request
        end
      end
    end
  end
end

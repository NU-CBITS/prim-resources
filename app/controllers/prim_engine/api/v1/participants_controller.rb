require 'hashids'

module PrimEngine
  module Api
    module V1
      # Manage Participants.
      class ParticipantsController < ApplicationController
        before_action :set_participant, only: [:show, :update, :destroy]

        def index
          if params[:external_id]
            @participants = Participant.where(external_id: params[:external_id])
          elsif params[:participant_id]
            @participants = Participant.where(id: params[:participant_id])
          else
            @participants = Participant.all
          end

          respond_to do |format|
            format.json { render json: @participants, root: false }
          end
        end

        def show
          respond_to do |format|
            format.json { render json: @participant, root: false }
          end
        end

        def create
          @participant = Participant.create
          hashid = Hashids.new('TODO:salt_here').encrypt(@participant.id)

          respond_to do |format|
            if @participant.update(external_id: hashid)
              format.json do
                render json: @participant, status: :created, root: false
              end
            else
              format.json do
                render json: @participant.errors,
                       status: :unprocessable_entity,
                       root: false
              end
            end
          end
        end

        def update
          respond_to do |format|
            if @participant.update(participant_params)
              format.json { head :no_content, status: :ok }
            else
              format.json do
                render json: @participant.errors,
                       status: :unprocessable_entity,
                       root: false
              end
            end
          end
        end

        def destroy
          respond_to do |format|
            if @participant.destroy
              format.json { head :no_content, status: :ok }
            else
              format.json do
                render json: @participant.errors,
                       status: :unprocessable_entity,
                       root: false
              end
            end
          end
        end

        private

        # Use callbacks to share common setup or constraints between actions.
        def set_participant
          @participant = Participant.find_by(external_id: params[:external_id])
        end

        # Only allow a trusted parameter "white list" through.
        def participant_params
          params.require(:participant).permit(:id, :external_id)
        end
      end
    end
  end
end

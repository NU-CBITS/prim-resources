require 'hashids'

module PrimEngine
  module Api
    module V1
      # Manage Participant Screenings.
      class ScreeningsController < ApplicationController
        before_action :set_screening, only: [:update, :destroy]

        skip_before_action :verify_authenticity_token

        def index
          if params[:participant_id]
            @screenings = Screening
                          .where(participant_id: params[:participant_id])
          else
            @screenings = Screening.all
          end

          respond_to do |format|
            format.json { render json: @screenings }
          end
        end

        def show
          if params[:participant_id]
            @screenings = Screening
                          .where(participant_id: params[:participant_id])
                          .reverse_order
          else
            @screenings = Screening.all
          end
          respond_to do |format|
            format.json { render json: @screenings }
          end
        end

        def create
          @screening = Screening.create(screening_params)
          respond_to do |format|
            if @screening.save
              format.json { render json: @screening, status: :created }
            else
              format.json do
                render json: @screening.errors, status: :unprocessable_entity
              end
            end
          end
        end

        def update
          respond_to do |format|
            if @screening.update(screening_params)
              format.json { head :no_content, status: :ok }
            else
              format.json do
                render json: @screening.errors, status: :unprocessable_entity
              end
            end
          end
        end

        def destroy
          respond_to do |format|
            if @screening.destroy
              format.json { head :no_content, status: :ok }
            else
              format.json do
                render json: @screening.errors, status: :unprocessable_entity
              end
            end
          end
        end

        private

        # Use callbacks to share common setup or constraints between actions.
        def set_screening
          @screening = Screening.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def screening_params
          params.require(:screening).permit(:id, :site_id, :participant_id,
                                            :question, :answer, :position)
        end
      end
    end
  end
end

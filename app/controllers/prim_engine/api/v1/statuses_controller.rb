module PrimEngine
  module Api
    module V1
      # Manage Participant Statuses.
      class StatusesController < ApplicationController
        before_action :set_status, only: [:show, :update, :destroy]

        def index
          if params[:participant_id]
            @statuses = Status.where(participant_id: params[:participant_id])
          elsif params[:id]
            @statuses = Status.where(id: params[:id])
          else
            @statuses = Status.all
          end
          respond_to do |format|
            format.json { render json: @statuses, root: false }
          end
        end

        def show
          respond_to do |format|
            format.json { render json: @status, root: false }
          end
        end

        def create
          @status = Status.new(status_params)

          respond_to do |format|
            if @status.save
              format.json do
                render json: @status, status: :created, root: false
              end
            else
              format.json do
                render json: @status.errors,
                       status: :unprocessable_entity,
                       root: false
              end
            end
          end
        end

        def update
          respond_to do |format|
            if @status.update(status_params)
              format.json { head :no_content, status: :ok }
            else
              format.json do
                render json: @status.errors,
                       status: :unprocessable_entity,
                       root: false
              end
            end
          end
        end

        def destroy
          respond_to do |format|
            if @status.destroy
              format.json { head :no_content, status: :ok }
            else
              format.json do
                render json: @status.errors,
                       status: :unprocessable_entity,
                       root: false
              end
            end
          end
        end

        private

        # Use callbacks to share common setup or constraints between actions.
        def set_status
          @status = Status.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def status_params
          params.permit(:id, :name, :description, :participant_id, :final,
                        :site_id)
        end
      end
    end
  end
end

module PrimEngine
  class Api::V1::StatusesController < ApplicationController
    before_action :set_status, only: [:show, :edit, :update, :destroy]
    skip_before_filter :verify_authenticity_token

    def index
      if params[:participant_id]
        @statuses = Status.where(participant_id: params[:participant_id])
      elsif params[:id]
        @statuses = Status.where(id: params[:id])
      else
        @statuses = Status.all
      end
      respond_to do |format|
        format.json { render json: @statuses }
      end
    end

    def show
      respond_to do |format|
        format.json { render json: @statuses }
      end
    end

    def create
      @status = Status.new(status_params)

      respond_to do |format|
        if @status.save
          format.json { render json: @status, status: :created }
        else
          format.json { render json: @status.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        puts '~~~' + status_params.inspect
        if @status.update(status_params)
          format.json { head :no_content, status: :ok }
        else
          format.json { render json: @status.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      respond_to do |format|
        if @status.destroy
          format.json { head :no_content, status: :ok }
        else
          format.json { render json: @status.errors, status: :unprocessable_entity }
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
        params.permit(:id, :name, :description, :participant_id, :final, :site_id)
      end
  end
end

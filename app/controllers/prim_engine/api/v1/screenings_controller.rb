require 'hashids'

module PrimEngine
  class Api::V1::ScreeningsController < ApplicationController
    before_action :set_screening, only: [:show, :edit, :update, :destroy]

    skip_before_filter :verify_authenticity_token

    def index
      if params[:external_id]
        @screenings = Screening.find(params[:id])
      else
        @screenings = Screening.all
      end

      respond_to do |format|
        format.json { render json: @screenings }
      end

    end

    def show
      respond_to do |format|
        format.json { render json: @screening }
      end
    end

    def create
      @screening = Screening.create
      respond_to do |format|
        if @screening.save
          format.json { render json: @screening, status: :created }
        else
          format.json { render json: @screening.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @screening.update(screening_params)
          format.json { head :no_content, status: :ok }
        else
          format.json { render json: @screening.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      respond_to do |format|
        if @screening.destroy
          format.json { head :no_content, status: :ok }
        else
          format.json { render json: @screening.errors, status: :unprocessable_entity }
        end
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_screening
      @screening = Screening.find_by(external_id: params[:external_id])
    end

    # Only allow a trusted parameter "white list" through.
    def screening_params
      params.require(:screening).permit(:id, :site_id, :participant_id, :question, :answer)
    end
  end
end

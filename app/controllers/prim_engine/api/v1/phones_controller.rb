module PrimEngine
  class Api::V1::PhonesController < ApplicationController
    before_action :set_phone, only: [:show, :edit, :update, :destroy]
    skip_before_filter :verify_authenticity_token

    def index
      @phones = Phone.all
      respond_to do |format|
        format.json { render json: @phones }
      end
    end

    def show
      respond_to do |format|
        format.json { render json: @phones }
      end
    end

    def create
      @phone = Phone.new(phone_params)

      respond_to do |format|
        if @phone.save
          format.json { render json: @phone, status: :created }
        else
          format.json { render json: @phone.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @phone.update(phone_params)
          format.json { head :no_content, status: :ok }
        else
          format.json { render json: @phone.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      respond_to do |format|
        if @phone.destroy
          format.json { head :no_content, status: :ok }
        else
          format.json { render json: @phone.errors, status: :unprocessable_entity }
        end
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_participant
        @phone = Phone.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def phone_params
        params.permit(:id, :number, :name, :primary, :participant_id)
      end
  end
end

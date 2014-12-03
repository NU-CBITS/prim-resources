module PrimEngine
  module Api
    module V1
      # Manage Participant Phones.
      class PhonesController < ApplicationController
        before_action :set_phone, only: [:show, :update, :destroy]
        skip_before_action :verify_authenticity_token

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
              format.json do
                render json: @phone.errors, status: :unprocessable_entity
              end
            end
          end
        end

        def update
          respond_to do |format|
            if @phone.update(phone_params)
              format.json { head :no_content, status: :ok }
            else
              format.json do
                render json: @phone.errors, status: :unprocessable_entity
              end
            end
          end
        end

        def destroy
          respond_to do |format|
            if @phone.destroy
              format.json { head :no_content, status: :ok }
            else
              format.json do
                render json: @phone.errors, status: :unprocessable_entity
              end
            end
          end
        end

        private

        # Use callbacks to share common setup or constraints between actions.
        def set_phone
          @phone = Phone.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def phone_params
          params.permit(:id, :number, :name, :primary, :participant_id)
        end
      end
    end
  end
end

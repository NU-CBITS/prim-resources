module PrimEngine
  module Api
    module V1
      # Manage Participant Addresses.
      class AddressesController < ApplicationController
        before_action :set_address, only: [:show, :update, :destroy]

        def index
          @addresses = Address.all
          respond_to do |format|
            format.json { render json: @addresses, root: false }
          end
        end

        def show
          respond_to do |format|
            format.json { render json: @address, root: false }
          end
        end

        def create
          @address = Address.new(address_params)

          respond_to do |format|
            if @address.save
              format.json do
                render json: @address, status: :created, root: false
              end
            else
              format.json do
                render json: @address.errors,
                       status: :unprocessable_entity,
                       root: false
              end
            end
          end
        end

        def update
          respond_to do |format|
            if @address.update(address_params)
              format.json { head :no_content, status: :ok }
            else
              format.json do
                render json: @address.errors,
                       status: :unprocessable_entity,
                       root: false
              end
            end
          end
        end

        def destroy
          respond_to do |format|
            if @address.destroy
              format.json { head :no_content, status: :ok }
            else
              format.json do
                render json: @address.errors,
                       status: :unprocessable_entity,
                       root: false
              end
            end
          end
        end

        private

        # Use callbacks to share common setup or constraints between actions.
        def set_address
          @address = Address.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def address_params
          params.permit(:id, :street_1, :street_2, :city, :state, :zip,
                        :primary, :participant_id)
        end
      end
    end
  end
end

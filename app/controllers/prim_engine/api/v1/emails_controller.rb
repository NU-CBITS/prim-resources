module PrimEngine
  module Api
    module V1
      # Manage Participant Emails.
      class EmailsController < ApplicationController
        before_action :set_email, only: [:show, :update, :destroy]

        def index
          @emails = Email.all
          respond_to do |format|
            format.json { render json: @emails, root: false }
          end
        end

        def show
          respond_to do |format|
            format.json { render json: @email, root: false }
          end
        end

        def create
          @email = Email.new(email_params)

          respond_to do |format|
            if @email.save
              format.json { render json: @email, status: :created, root: false }
            else
              format.json do
                render json: @email.errors,
                       status: :unprocessable_entity,
                       root: false
              end
            end
          end
        end

        def update
          respond_to do |format|
            if @email.update(email_params)
              format.json { head :no_content, status: :ok }
            else
              format.json do
                render json: @email.errors,
                       status: :unprocessable_entity,
                       root: false
              end
            end
          end
        end

        def destroy
          respond_to do |format|
            if @email.destroy
              format.json { head :no_content, status: :ok }
            else
              format.json do
                render json: @email.errors,
                       status: :unprocessable_entity,
                       root: false
              end
            end
          end
        end

        private

        # Use callbacks to share common setup or constraints between actions.
        def set_email
          @email = Email.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def email_params
          params.permit(:id, :email, :primary, :participant_id)
        end
      end
    end
  end
end

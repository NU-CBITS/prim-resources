class Api::V1::ParticipantsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def index
    @participants = Participant.all
    respond_to do |format|
      format.json { render json: @participants }
    end
  end

  def show
    @participant = Participant.find(params[:id])
    respond_to do |format|
      format.json { render json: @participant }
    end
  end

  def create
    @participant = Participant.new(participant_params)
    respond_to do |format|
      if @participant.save
        format.json { render json: @participant, status: :created }
      else
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @participant = Participant.find(params[:id])
    respond_to do |format|
      if @participant.update(participant_params)
        format.json { head :no_content, status: :ok }
      else
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @participant = Participant.find(params[:id])
    respond_to do |format|
      if @participant.destroy
        format.json { head :no_content, status: :ok }
      else
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def participant_params
    params.require(:participant).permit(:email, :first_name, :last_name, :phone, :date_of_birth)
  end
end
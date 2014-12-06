# nodoc
class ApplicationController < ActionController::Base
  AUTH_HEADER = 'X-AUTH-TOKEN'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  skip_before_action :verify_authenticity_token, if: :json_request?
  before_action :authenticate_consumer!, if: :json_request?

  rescue_from 'ActionController::ParameterMissing',
              with: :missing_parameter,
              if: :json_request?

  protected

  attr_reader :current_consumer

  def json_request?
    @is_json_request ||= request.format.json?
  end

  def authenticate_consumer!
    @current_consumer = ApiConsumer.find_by_ip_address(request.remote_ip)

    return if @current_consumer.try(:valid_token?, request.headers[AUTH_HEADER])

    render json: [PrimEngine::ApiError.new(status: 'Unauthorized')],
           each_serializer: PrimEngine::Serializers::ApiError,
           root: 'errors',
           status: :unauthorized
  end

  def missing_parameter
    render json: [PrimEngine::ApiError.new(status: 'Bad Request')],
           each_serializer: PrimEngine::Serializers::ApiError,
           root: 'errors',
           status: :bad_request
  end
end

require 'prim_engine'

# nodoc
class ApplicationController < ActionController::Base
  TOKEN_HEADER = 'X-AUTH-TOKEN'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  skip_before_action :verify_authenticity_token, if: :json_request?
  before_action :authenticate_consumer!, if: :json_request?

  protected

  def json_request?
    @is_json_request ||= request.format.json?
  end

  def authenticate_consumer!
    consumer = ApiConsumer.find_by_ip_address(request.remote_ip)

    return if consumer && consumer.valid_token?(request.headers[TOKEN_HEADER])

    render json: [PrimEngine::ApiError.new(status: 'Unauthorized')],
           each_serializer: PrimEngine::Serializers::ApiError,
           root: 'errors',
           status: :unauthorized
  end
end

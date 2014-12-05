module PrimEngine
  # Represents an error to be transmitted to the API Consumer.
  class ApiError
    include ActiveModel::SerializerSupport

    attr_reader :id, :status, :detail

    def initialize(status: 'Error', detail: '')
      @id = SecureRandom.uuid
      @status = status
      @detail = detail
    end
  end
end

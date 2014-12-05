module PrimEngine
  # Represents an error to be transmitted to the API Consumer.
  class ApiError
    include ActiveModel::SerializerSupport

    attr_reader :id, :status

    def initialize(status: 'Error')
      @id = SecureRandom.uuid
      @status = status
    end
  end
end

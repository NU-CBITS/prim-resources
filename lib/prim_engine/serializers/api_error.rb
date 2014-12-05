module PrimEngine
  module Serializers
    # Serialize API Errors.
    class ApiError < ActiveModel::Serializer
      attributes :id, :status, :detail
    end
  end
end

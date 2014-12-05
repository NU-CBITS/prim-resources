# nodoc
module PrimEngine
  autoload :ApiError, 'prim_engine/api_error'

  # Classes responsible for JSON serialization.
  module Serializers
    autoload :ApiError, 'prim_engine/serializers/api_error'
    autoload :Participant, 'prim_engine/serializers/participant'
    autoload :Project, 'prim_engine/serializers/project'
  end
end

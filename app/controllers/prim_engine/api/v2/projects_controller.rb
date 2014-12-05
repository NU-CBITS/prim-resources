require 'prim_engine/serializers/project'

module PrimEngine
  module Api
    module V2
      # Actions for Project resources.
      class ProjectsController < ApplicationController
        def index
          render json: Project.select(:external_id, :name),
                 each_serializer: PrimEngine::Serializers::Project
        end
      end
    end
  end
end

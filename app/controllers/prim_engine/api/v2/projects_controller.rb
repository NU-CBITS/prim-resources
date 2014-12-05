require 'prim_engine'

module PrimEngine
  module Api
    module V2
      # Actions for Project resources.
      class ProjectsController < ApplicationController
        def index
          render json: Project.select(:external_id, :name),
                 each_serializer: PrimEngine::Serializers::Project
        end

        def show
          if find_project
            render json: @project,
                   serializer: PrimEngine::Serializers::Project,
                   root: 'projects'
          else
            render json: PrimEngine::ApiError.new,
                   serializer: PrimEngine::Serializers::ApiError,
                   root: 'errors',
                   status: :not_found
          end
        end

        private

        def find_project
          @project = Project.find_by_external_id(params[:id])
        end
      end
    end
  end
end

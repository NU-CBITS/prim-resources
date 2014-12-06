module PrimEngine
  module Api
    module V2
      # Actions for Project resources.
      class ProjectsController < ApplicationController
        def index
          render json: scope_projects
            .includes(:participants)
            .select(:id, :external_id, :name),
                 each_serializer: PrimEngine::Serializers::Project
        end

        def show
          if find_project
            render json: @project,
                   serializer: PrimEngine::Serializers::Project,
                   root: 'projects'
          else
            render json: PrimEngine::ApiError.new(status: 'Not Found'),
                   serializer: PrimEngine::Serializers::ApiError,
                   root: 'errors',
                   status: :not_found
          end
        end

        private

        def find_project
          @project = scope_projects.find_by_external_id(params[:id])
        end

        # A Consumer is either privy to all Projects, or to a single one.
        def scope_projects
          if current_consumer.project_id
            @projects = Project.where(id: current_consumer.project_id)
          else
            @projects = Project
          end
        end
      end
    end
  end
end

require 'rails_helper'

RSpec.describe 'Projects resource', type: :request do
  include_examples 'requests'

  fixtures :all

  describe 'GET /v2/projects' do
    context 'for a consumer scoped to a single project' do
      it 'sends the project' do
        get '/v2/projects', nil, single_project_auth_header

        expect(response).to be_success
        expect(json['projects'].length).to be 1
      end
    end

    context 'for a consumer scoped to all projects' do
      it 'sends the projects' do
        get '/v2/projects', nil, all_project_auth_header

        expect(response).to be_success
        expect(json['projects'].length).to be Project.count
      end
    end
  end

  describe 'GET /v2/projects/:id' do
    context 'when the project is found' do
      let(:project) { projects(:project_99) }

      it 'sends the project' do
        get "/v2/projects/#{ project.external_id }",
            nil,
            all_project_auth_header

        expect(response).to be_success
        expect(json['projects']['id']).to eq project.external_id
      end
    end

    context 'when the project is not found anywhere' do
      it 'sends an error' do
        get '/v2/projects/baz', nil, all_project_auth_header

        expect(response).to be_not_found
        expect(json['errors']).not_to be_nil
      end
    end

    context 'when the project is not found for a consumer' do
      it 'sends an error' do
        get "/v2/projects/#{ projects(:project_5).external_id }",
            nil,
            single_project_auth_header

        expect(response).to be_not_found
        expect(json['errors']).not_to be_nil
      end
    end
  end
end

require 'rails_helper'

RSpec.describe 'Projects resource', type: :request do
  fixtures :all

  describe 'GET /v2/projects' do
    it 'sends the projects' do
      get '/v2/projects', nil, @auth_header

      expect(response).to be_success
      expect(json['projects'].length).to be Project.count
    end
  end

  describe 'GET /v2/projects/:id' do
    context 'when the project is found' do
      let(:project) { projects(:project_99) }

      it 'sends the project' do
        get "/v2/projects/#{ project.external_id }", nil, @auth_header

        expect(response).to be_success
        expect(json['projects']['id']).to eq project.external_id
      end
    end

    context 'when the project is not found' do
      it 'sends an error' do
        get '/v2/projects/baz', nil, @auth_header

        expect(response).to be_not_found
        expect(json['errors']).not_to be_nil
      end
    end
  end
end

require 'rails_helper'

RSpec.describe 'Projects resource', type: :request do
  fixtures :all

  describe 'GET /v2/projects' do
    it 'sends the projects' do
      get '/v2/projects', nil, @auth_header

      expect(response).to be_success
      expect(json['projects'].length).to eq Project.count
    end
  end
end

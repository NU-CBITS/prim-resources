# Methods for request specs.
module RequestHelpers
  def json
    @json ||= JSON.parse(response.body)
  end
end

RSpec.shared_examples 'requests' do
  let(:single_project_auth_header) do
    project = Project.first
    unless project.nil?
      consumer = ApiConsumer.find_or_create_by(
        name: 'local',
        ip_address: '127.0.0.1',
        project: project
      )

      { 'X-AUTH-TOKEN' => consumer.token }
    end
  end

  let(:all_project_auth_header) do
    consumer = ApiConsumer.find_or_create_by(
      name: 'local',
      ip_address: '127.0.0.1'
    )

    { 'X-AUTH-TOKEN' => consumer.token }
  end
end

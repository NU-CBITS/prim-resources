require 'rails_helper'

RSpec.describe Project, type: :model do
  it 'generates an external_id on creation' do
    UUID = /\w{8}-\w{4}-\w{4}-\w{4}-\w{12}/
    expect(Project.create!(name: 'Foo').external_id).to match(UUID)
  end
end

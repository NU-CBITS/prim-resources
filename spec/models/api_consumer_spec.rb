require 'rails_helper'

RSpec.describe ApiConsumer, type: :model do
  fixtures :all

  let(:consumer) do
    ApiConsumer.create!(
      name: 'foo',
      ip_address: '127.0.0.1',
      project: projects(:project_42)
    )
  end

  it 'generates an encrypted_token on creation' do
    expect(consumer.encrypted_token).not_to be_nil
  end

  describe '#valid_token?' do
    it 'returns false for an empty token' do
      expect(consumer.valid_token?(nil)).to be false
      expect(consumer.valid_token?('')).to be false
    end
  end
end

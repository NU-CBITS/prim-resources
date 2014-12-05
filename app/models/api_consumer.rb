require 'bcrypt'

# A registered client that uses the API.
class ApiConsumer < ActiveRecord::Base
  SALT_LENGTH = 6
  TOKEN_LENGTH = 32
  BCRYPT_COST = 4

  belongs_to :project

  attr_reader :token

  validates :name, :token_salt, :encrypted_token, :ip_address,
            presence: true

  before_validation :generate_token

  def valid_token?(token)
    return false if token.blank?

    BCrypt::Password.new(encrypted_token) == (token_salt + token.to_s)
  end

  private

  def generate_token
    return unless token_salt.nil? || encrypted_token.nil?

    self.token_salt = SecureRandom.hex(SALT_LENGTH)
    @token = SecureRandom.hex(TOKEN_LENGTH)
    BCrypt::Engine.cost = BCRYPT_COST
    self.encrypted_token = BCrypt::Password.create(token_salt + @token)
  end
end

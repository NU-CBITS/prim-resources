# A use case for this application.
class Project < ActiveRecord::Base
  has_many :memberships
  has_many :participants, through: :memberships

  validates :name, presence: true, uniqueness: true
  validates :external_id, presence: true

  before_validation :generate_external_id

  private

  def generate_external_id
    self.external_id ||= SecureRandom.uuid
  end
end

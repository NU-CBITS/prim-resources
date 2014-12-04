# A use case for this application.
class Project < ActiveRecord::Base
  has_many :memberships
  has_many :participants, through: :memberships

  validates :name, presence: true, uniqueness: true
end

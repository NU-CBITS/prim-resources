# A Participant in a Project.
class Membership < ActiveRecord::Base
  belongs_to :project
  belongs_to :participant

  validates :project, :participant, presence: true
  validates :participant_id, uniqueness: { scope: :project_id }
end

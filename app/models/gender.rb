# Participant's gender.
class Gender < ActiveRecord::Base
  belongs_to :participant

  validates :participant, :value, presence: true
end

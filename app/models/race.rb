# Participant's race.
class Race < ActiveRecord::Base
  belongs_to :participant

  validates :participant, :value, presence: true
end

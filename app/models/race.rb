# Participant's race.
class Race < ActiveRecord::Base
  belongs_to :participant

  validates :value, presence: true
end

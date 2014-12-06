# Participant's ethnic background.
class Ethnicity < ActiveRecord::Base
  belongs_to :participant

  validates :participant, :value, presence: true
end

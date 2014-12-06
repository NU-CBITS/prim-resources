# Participant's ethnic background.
class Ethnicity < ActiveRecord::Base
  belongs_to :participant

  validates :value, presence: true
end

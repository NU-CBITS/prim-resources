# Participant's gender.
class Gender < ActiveRecord::Base
  belongs_to :participant

  validates :value, presence: true
end

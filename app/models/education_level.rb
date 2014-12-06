# Highest level of education attained.
class EducationLevel < ActiveRecord::Base
  belongs_to :participant

  validates :participant, :value, presence: true
end

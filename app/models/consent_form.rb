# Generated when a Participant signs a form.
class ConsentForm < ActiveRecord::Base
  belongs_to :participant

  validates :version, length: { maximum: 36 }
end

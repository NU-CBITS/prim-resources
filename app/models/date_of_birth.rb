# Author::  Eric Schlange (mailto:eric.schlange@northwestern.edu)
# License:: GPLv2

# Participant's date of birth.
class DateOfBirth < ActiveRecord::Base
  belongs_to :participant
end

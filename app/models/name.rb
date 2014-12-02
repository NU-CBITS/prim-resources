# Author::  Eric Schlange (mailto:eric.schlange@northwestern.edu)
# License:: GPLv2

# Participant's legal name.
class Name < ActiveRecord::Base
  belongs_to :participant
end

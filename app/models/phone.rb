# Author::  Eric Schlange (mailto:eric.schlange@northwestern.edu)
# License:: GPLv2

# Participant phone number.
class Phone < ActiveRecord::Base
  belongs_to :participant
end

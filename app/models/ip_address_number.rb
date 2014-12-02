# Author::  Eric Schlange (mailto:eric.schlange@northwestern.edu)
# License:: GPLv2

# Participant's IP address.
class IpAddressNumber < ActiveRecord::Base
  belongs_to :participant
end

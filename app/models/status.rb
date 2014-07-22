# Author::  Eric Schlange (mailto:eric.schlange@northwestern.edu)
# License:: GPLv2

# Description goes here.
class Status < ActiveRecord::Base
  belongs_to :participant
end

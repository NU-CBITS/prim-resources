class Participant < ActiveRecord::Base
  validates :email, :presence => true
  validates_uniqueness_of :email

end

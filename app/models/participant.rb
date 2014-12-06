# Person registered in the system.
class Participant < ActiveRecord::Base
  def to_param  # overridden
    external_id
  end

  has_one :date_of_birth,
          -> { select(:participant_id, :date) },
          dependent: :destroy
  has_one :name, (lambda do
    select(:participant_id, :first_name, :last_name, :middle_name, :prefix,
           :suffix)
  end),
          dependent: :destroy
  has_one :social_security_number,
          dependent: :destroy
  has_one :gender,
          -> { select(:participant_id, :value) },
          dependent: :destroy
  has_one :ethnicity,
          -> { select(:participant_id, :value) },
          dependent: :destroy
  has_one :race,
          -> { select(:participant_id, :value) },
          dependent: :destroy
  has_one :education_level,
          -> { select(:participant_id, :value) },
          dependent: :destroy

  has_many :addresses, (lambda do
    select(:participant_id, :name, :street_1, :street_2, :city, :state, :zip,
           :primary)
  end),
           dependent: :destroy
  has_many :emails,
           -> { select(:participant_id, :email, :primary) },
           dependent: :destroy
  has_many :health_insurance_beneficiary_numbers,
           dependent: :destroy
  has_many :ip_address_numbers,
           dependent: :destroy
  has_many :medical_record_numbers,
           dependent: :destroy
  has_many :phones,
           -> { select(:participant_id, :name, :number, :primary) },
           dependent: :destroy

  before_validation :generate_external_id

  accepts_nested_attributes_for :date_of_birth
  accepts_nested_attributes_for :gender
  accepts_nested_attributes_for :ethnicity
  accepts_nested_attributes_for :race
  accepts_nested_attributes_for :education_level

  private

  def generate_external_id
    self.external_id ||= SecureRandom.uuid
  end
end

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

  accepts_nested_attributes_for :date_of_birth, reject_if: :all_blank
  accepts_nested_attributes_for :name, reject_if: :all_blank
  accepts_nested_attributes_for :gender, reject_if: :all_blank
  accepts_nested_attributes_for :ethnicity, reject_if: :all_blank
  accepts_nested_attributes_for :race, reject_if: :all_blank
  accepts_nested_attributes_for :education_level, reject_if: :all_blank
  accepts_nested_attributes_for :addresses, reject_if: :all_blank
  accepts_nested_attributes_for :emails, reject_if: :all_blank
  accepts_nested_attributes_for :phones, reject_if: :all_blank

  private

  def generate_external_id
    self.external_id ||= SecureRandom.uuid
  end
end

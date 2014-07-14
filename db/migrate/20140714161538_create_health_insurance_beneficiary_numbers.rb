class CreateHealthInsuranceBeneficiaryNumbers < ActiveRecord::Migration
  def change
    create_table :health_insurance_beneficiary_numbers do |t|
      t.string :number
      t.references :participant, index: true

      t.timestamps

    end
  end
end

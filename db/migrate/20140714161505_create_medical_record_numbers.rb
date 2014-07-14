class CreateMedicalRecordNumbers < ActiveRecord::Migration
  def change
    create_table :medical_record_numbers do |t|
      t.string :number
      t.string :name
      t.string :description
      t.references :participant, index: true

      t.timestamps
    end
  end
end

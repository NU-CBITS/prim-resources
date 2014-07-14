class CreateDateOfBirths < ActiveRecord::Migration
  def change
    create_table :date_of_births do |t|
      t.date :date_of_birth
      t.references :participant, index: true

      t.timestamps
    end
  end
end

class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :name
      t.string :number
      t.boolean :primary
      t.references :participant, index: true

      t.timestamps
    end
  end
end

class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :name
      t.string :street_1
      t.string :street_2
      t.string :city
      t.string :state
      t.string :zip
      t.boolean :primary
      t.references :participant, index: true

      t.timestamps
    end
  end
end

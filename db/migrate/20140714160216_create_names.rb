class CreateNames < ActiveRecord::Migration
  def change
    create_table :names do |t|
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :prefix
      t.string :suffix
      t.references :participant, index: true

      t.timestamps
    end
  end
end

class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :email
      t.boolean :primary
      t.references :participant, index: true

      t.timestamps
    end
  end
end

class CreateScreening < ActiveRecord::Migration
  def change
    create_table :screenings do |t|
      t.integer :site_id
      t.references :participant, index: true
      t.string :question
      t.string :answer
    end
  end
end

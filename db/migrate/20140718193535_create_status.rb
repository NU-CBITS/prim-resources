class CreateStatus < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.references :participant, index: true
      t.integer :site_id
      t.string :name
      t.string :description
      t.boolean :final
    end
  end
end

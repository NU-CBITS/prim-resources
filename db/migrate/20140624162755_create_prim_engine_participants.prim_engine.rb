# This migration comes from prim_engine (originally 20140624145604)
class CreatePrimEngineParticipants < ActiveRecord::Migration
  def change
    create_table :prim_engine_participants do |t|
      t.string :email
      t.string :last_name
      t.date :date_of_birth
      t.string :phone

      t.timestamps
    end
  end
end

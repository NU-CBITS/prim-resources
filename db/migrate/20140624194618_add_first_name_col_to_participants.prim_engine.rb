# This migration comes from prim_engine (originally 20140624192417)
class AddFirstNameColToParticipants < ActiveRecord::Migration
  def change
    add_column :prim_engine_participants, :first_name, :string
  end
end

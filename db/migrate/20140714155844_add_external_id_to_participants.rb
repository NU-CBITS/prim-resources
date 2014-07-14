class AddExternalIdToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :external_id, :string
    add_index :participants, :external_id
  end
end

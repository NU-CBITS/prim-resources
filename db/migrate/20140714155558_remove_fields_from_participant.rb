class RemoveFieldsFromParticipant < ActiveRecord::Migration
  def change
    remove_column :participants, :email
    remove_column :participants, :date_of_birth
    remove_column :participants, :phone
    remove_column :participants, :first_name
    remove_column :participants, :last_name
  end
end

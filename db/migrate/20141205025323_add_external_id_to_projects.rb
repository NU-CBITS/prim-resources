class AddExternalIdToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :external_id, :string
    reversible do |dir|
      dir.up do
        Project.all.each &:save
      end
    end
    change_column_null :projects, :external_id, false
  end
end

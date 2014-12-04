class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :project_id, null: false
      t.integer :participant_id, null: false

      t.timestamps
    end

    add_index :memberships, [:project_id, :participant_id], unique: true

    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE memberships
            ADD CONSTRAINT fk_memberships_projects
            FOREIGN KEY (project_id)
            REFERENCES projects(id)
        SQL

        execute <<-SQL
          ALTER TABLE memberships
            ADD CONSTRAINT fk_memberships_participants
            FOREIGN KEY (participant_id)
            REFERENCES participants(id)
        SQL
      end

      dir.down do
        execute <<-SQL
          ALTER TABLE memberships
            DROP CONSTRAINT IF EXISTS fk_memberships_projects
        SQL

        execute <<-SQL
          ALTER TABLE memberships
            DROP CONSTRAINT IF EXISTS fk_memberships_participants
        SQL
      end
    end
  end
end

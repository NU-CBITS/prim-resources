class CreateApiConsumers < ActiveRecord::Migration
  def change
    create_table :api_consumers do |t|
      t.string :name, null: false
      t.string :token_salt, null: false
      t.string :encrypted_token, null: false
      t.string :ip_address, null: false
      t.integer :project_id, null: false

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE api_consumers
            ADD CONSTRAINT fk_api_consumers_projects
            FOREIGN KEY (project_id)
            REFERENCES projects(id)
        SQL
      end

      dir.down do
        execute <<-SQL
          ALTER TABLE api_consumers
            DROP CONSTRAINT IF EXISTS fk_api_consumers_projects
        SQL
      end
    end
  end
end

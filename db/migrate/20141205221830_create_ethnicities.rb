class CreateEthnicities < ActiveRecord::Migration
  def change
    create_table :ethnicities do |t|
      t.text :value, null: false
      t.references :participant, index: true

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE ethnicities
            ADD CONSTRAINT fk_ethnicities_participants
            FOREIGN KEY (participant_id)
            REFERENCES participants(id)
        SQL
      end

      dir.down do
        execute <<-SQL
          ALTER TABLE genders
            DROP CONSTRAINT IF EXISTS fk_ethnicities_participants
        SQL
      end
    end
  end
end

class CreateEducationLevels < ActiveRecord::Migration
  def change
    create_table :education_levels do |t|
      t.string :value, null: false
      t.references :participant, index: true

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE education_levels
            ADD CONSTRAINT fk_education_levels_participants
            FOREIGN KEY (participant_id)
            REFERENCES participants(id)
        SQL
      end

      dir.down do
        execute <<-SQL
          ALTER TABLE genders
            DROP CONSTRAINT IF EXISTS fk_education_levels_participants
        SQL
      end
    end
  end
end

class CreateGenders < ActiveRecord::Migration
  def change
    create_table :genders do |t|
      t.string :value, null: false
      t.references :participant, index: true

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE genders
            ADD CONSTRAINT fk_genders_participants
            FOREIGN KEY (participant_id)
            REFERENCES participants(id)
        SQL
      end

      dir.down do
        execute <<-SQL
          ALTER TABLE genders
            DROP CONSTRAINT IF EXISTS fk_genders_participants
        SQL
      end
    end
  end
end

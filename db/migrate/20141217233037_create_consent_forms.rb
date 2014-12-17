class CreateConsentForms < ActiveRecord::Migration
  def change
    create_table :consent_forms do |t|
      t.date :expires_on, null: false
      t.string :study_number, null: false
      t.references :participant, index: true, null: false
      t.string :source

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE consent_forms
            ADD CONSTRAINT fk_consent_forms_participants
            FOREIGN KEY (participant_id)
            REFERENCES participants(id)
        SQL
      end

      dir.down do
        execute <<-SQL
          ALTER TABLE consent_forms
            DROP CONSTRAINT IF EXISTS fk_consent_forms_participants
        SQL
      end
    end
  end
end

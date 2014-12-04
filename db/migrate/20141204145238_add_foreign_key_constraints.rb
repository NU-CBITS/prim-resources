class AddForeignKeyConstraints < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE addresses
            ADD CONSTRAINT fk_addresses_participants
            FOREIGN KEY (participant_id)
            REFERENCES participants(id)
        SQL

        execute <<-SQL
          ALTER TABLE date_of_births
            ADD CONSTRAINT fk_date_of_births_participants
            FOREIGN KEY (participant_id)
            REFERENCES participants(id)
        SQL

        execute <<-SQL
          ALTER TABLE emails
            ADD CONSTRAINT fk_emails_participants
            FOREIGN KEY (participant_id)
            REFERENCES participants(id)
        SQL

        execute <<-SQL
          ALTER TABLE health_insurance_beneficiary_numbers
            ADD CONSTRAINT fk_hibns_participants
            FOREIGN KEY (participant_id)
            REFERENCES participants(id)
        SQL

        execute <<-SQL
          ALTER TABLE ip_address_numbers
            ADD CONSTRAINT fk_ip_addresses_participants
            FOREIGN KEY (participant_id)
            REFERENCES participants(id)
        SQL

        execute <<-SQL
          ALTER TABLE medical_record_numbers
            ADD CONSTRAINT fk_mrns_participants
            FOREIGN KEY (participant_id)
            REFERENCES participants(id)
        SQL

        execute <<-SQL
          ALTER TABLE names
            ADD CONSTRAINT fk_names_participants
            FOREIGN KEY (participant_id)
            REFERENCES participants(id)
        SQL

        execute <<-SQL
          ALTER TABLE phones
            ADD CONSTRAINT fk_phones_participants
            FOREIGN KEY (participant_id)
            REFERENCES participants(id)
        SQL

        # There is no corresponding ActiveRecord model class, and this table
        # doesn't appear to be used in the application.
        drop_table :prim_engine_participants

        execute <<-SQL
          ALTER TABLE screenings
            ADD CONSTRAINT fk_screenings_participants
            FOREIGN KEY (participant_id)
            REFERENCES participants(id)
        SQL

        execute <<-SQL
          ALTER TABLE social_security_numbers
            ADD CONSTRAINT fk_social_security_numbers_participants
            FOREIGN KEY (participant_id)
            REFERENCES participants(id)
        SQL

        execute <<-SQL
          ALTER TABLE statuses
            ADD CONSTRAINT fk_statuses_participants
            FOREIGN KEY (participant_id)
            REFERENCES participants(id)
        SQL
      end

      dir.down do
        execute <<-SQL
          ALTER TABLE addresses
            DROP CONSTRAINT IF EXISTS fk_addresses_participants
        SQL

        execute <<-SQL
          ALTER TABLE date_of_births
            DROP CONSTRAINT IF EXISTS fk_date_of_births_participants
        SQL

        execute <<-SQL
          ALTER TABLE emails
            DROP CONSTRAINT IF EXISTS fk_emails_participants
        SQL

        execute <<-SQL
          ALTER TABLE health_insurance_beneficiary_numbers
            DROP CONSTRAINT IF EXISTS fk_hibns_participants
        SQL

        execute <<-SQL
          ALTER TABLE ip_address_numbers
            DROP CONSTRAINT IF EXISTS fk_ip_addresses_participants
        SQL

        execute <<-SQL
          ALTER TABLE medical_record_numbers
            DROP CONSTRAINT IF EXISTS fk_mrns_participants
        SQL

        execute <<-SQL
          ALTER TABLE names
            DROP CONSTRAINT IF EXISTS fk_names_participants
        SQL

        execute <<-SQL
          ALTER TABLE phones
            DROP CONSTRAINT IF EXISTS fk_phones_participants
        SQL

        create_table :prim_engine_participants do |t|
          t.string :email
          t.string :last_name
          t.date :date_of_birth
          t.string :phone

          t.timestamps
        end

        execute <<-SQL
          ALTER TABLE screenings
            DROP CONSTRAINT IF EXISTS fk_screenings_participants
        SQL

        execute <<-SQL
          ALTER TABLE social_security_numbers
            DROP CONSTRAINT IF EXISTS fk_social_security_numbers_participants
        SQL

        execute <<-SQL
          ALTER TABLE statuses
            DROP CONSTRAINT IF EXISTS fk_statuses_participants
        SQL
      end
    end
  end
end

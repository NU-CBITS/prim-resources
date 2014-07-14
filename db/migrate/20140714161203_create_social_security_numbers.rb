class CreateSocialSecurityNumbers < ActiveRecord::Migration
  def change
    create_table :social_security_numbers do |t|
      t.string :number
      t.references :participant, index: true

      t.timestamps
    end
  end
end

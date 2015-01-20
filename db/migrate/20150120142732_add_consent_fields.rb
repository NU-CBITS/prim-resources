class AddConsentFields < ActiveRecord::Migration
  def change
    add_column :consent_forms, :signed_at, :datetime
    add_column :consent_forms, :version, :string, limit: 36
    add_column :consent_forms, :content, :text
  end
end

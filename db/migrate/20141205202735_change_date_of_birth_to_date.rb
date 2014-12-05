class ChangeDateOfBirthToDate < ActiveRecord::Migration
  def change
    rename_column :date_of_births, :date_of_birth, :date
  end
end

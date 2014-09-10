class AddPositionToScreeningQuestion < ActiveRecord::Migration
  def change
    add_column :screenings, :position, :integer
  end
end

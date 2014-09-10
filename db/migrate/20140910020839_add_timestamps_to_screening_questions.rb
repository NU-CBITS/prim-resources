class AddTimestampsToScreeningQuestions < ActiveRecord::Migration
  def change_table
    add_column(:screening_questions, :created_at, :datetime)
    add_column(:screening_questions, :updated_at, :datetime)
  end
end

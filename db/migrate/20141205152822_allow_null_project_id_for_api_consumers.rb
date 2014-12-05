class AllowNullProjectIdForApiConsumers < ActiveRecord::Migration
  def change
    change_column_null :api_consumers, :project_id, true
  end
end

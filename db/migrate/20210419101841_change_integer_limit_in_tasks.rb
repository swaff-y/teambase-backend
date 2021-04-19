class ChangeIntegerLimitInTasks < ActiveRecord::Migration[6.1]
  def change
    change_column :tasks, :due_date, :integer, limit: 8
  end
end

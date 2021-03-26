class AddTaskCategoryIdToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :task_category_id, :integer
  end
end

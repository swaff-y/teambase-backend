class RemoveDueDateFromProjects < ActiveRecord::Migration[6.1]
  def change
    remove_column :projects, :due_date, :date
  end
end

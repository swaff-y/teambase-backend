class AddDueDateToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :due_date, :integer
  end
end

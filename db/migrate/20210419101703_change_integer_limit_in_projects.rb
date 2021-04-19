class ChangeIntegerLimitInProjects < ActiveRecord::Migration[6.1]
  def change
      change_column :projects, :due_date, :integer, limit: 8
  end
end

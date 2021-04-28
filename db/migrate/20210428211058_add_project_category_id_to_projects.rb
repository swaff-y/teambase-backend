class AddProjectCategoryIdToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :project_category_id, :integer
  end
end

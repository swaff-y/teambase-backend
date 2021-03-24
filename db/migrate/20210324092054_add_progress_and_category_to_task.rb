class AddProgressAndCategoryToTask < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :progress, :integer
    add_column :tasks, :category, :text
  end
end

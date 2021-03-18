class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.date :due_date
      t.string :status
      t.integer :progress
      t.string :category
      t.text :description

      t.timestamps
    end
  end
end

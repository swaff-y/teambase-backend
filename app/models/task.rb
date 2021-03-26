class Task < ApplicationRecord
  belongs_to :project, optional: true
  belongs_to :task_category, optional: true
  has_and_belongs_to_many :users, association_foreign_key: "user_id", join_table: "tasks_users"
end

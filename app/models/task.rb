class Task < ApplicationRecord
  belongs_to :project, optional: true
  has_and_belongs_to_many :users, association_foreign_key: "user_id", join_table: "tasks_users"
end

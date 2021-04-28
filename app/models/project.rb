class Project < ApplicationRecord
  has_and_belongs_to_many :users, association_foreign_key: "user_id", join_table: "projects_users"
  has_many :tasks
  belongs_to :project_category, optional: true
end

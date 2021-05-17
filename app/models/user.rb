class User < ApplicationRecord
  has_secure_password
  # validates :email, presence: true,uniqueness: true, format: { with: VALID_EMAIL_REGEX }

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  has_and_belongs_to_many :tasks, association_foreign_key: "task_id", join_table: "tasks_users"
  has_and_belongs_to_many :projects, association_foreign_key: "project_id", join_table: "projects_users"
  has_many :notes
end

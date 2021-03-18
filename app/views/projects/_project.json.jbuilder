json.extract! project, :id, :name, :due_date, :status, :progress, :category, :description, :created_at, :updated_at
json.url project_url(project, format: :json)

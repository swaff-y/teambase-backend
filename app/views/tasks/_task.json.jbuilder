json.extract! task, :id, :name, :start_date, :due_date, :status, :description, :project_id, :created_at, :updated_at
json.url task_url(task, format: :json)

Rails.application.routes.draw do
  resources :project_categories
  resources :notes
  resources :task_categories
  resources :tasks
  root :to => 'pages#home'
  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'
  resources :users
  resources :projects

  get '/projects-user/:user' => 'projects#user_projects'
  get '/project-user/:project_id' => 'projects#user_project'
  get '/project-user-status/:project_id/:status' => 'projects#user_project_status'
  post '/project-priority-update/:project_id/:priority' => 'projects#project_priority_update'
  post '/task-create/:project_id' => 'tasks#create_task'
  delete '/task-delete/:task_id' => 'tasks#delete_task'
  get '/task-read/:task_id' => 'tasks#read_task'
  post '/task-update/:task_id' => 'tasks#update_task'
  post '/task-priority-update/:task_id/:priority' => 'tasks#task_priority_update'
  post '/note-create/:task_id/:user_id' => 'notes#create_note'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

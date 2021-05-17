Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
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

# todo
  # scope '/auth' do
  #   post '/signin' => 'user_token#create'
  #   # api routes
  # end
  post '/user_token' => 'user_token#create'
  post '/user_login' => 'users#user_login'


  get '/projects-user/:user' => 'projects#user_projects'
  get '/user-one/:user' => 'users#user_one'
  get '/project-read/:project_id' => 'projects#project_read'
  delete '/project-delete/:project_id' => 'projects#project_delete'
  get '/project-user/:project_id' => 'projects#user_project'
  get '/project-user-status/:project_id/:status' => 'projects#user_project_status'
  post '/project-priority-update/:project_id/:priority' => 'projects#project_priority_update'
  post '/project-create/:user_id' => 'projects#create_project'
  post '/task-create/:project_id' => 'tasks#create_task'
  delete '/task-delete/:task_id' => 'tasks#delete_task'
  get '/task-read/:task_id' => 'tasks#read_task'
  post '/task-update/:task_id' => 'tasks#update_task'
  post '/project-update/:project_id' => 'projects#update_project'
  post '/task-priority-update/:task_id/:priority' => 'tasks#task_priority_update'
  post '/note-create/:task_id/:user_id' => 'notes#create_note'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

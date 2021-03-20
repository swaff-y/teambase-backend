Rails.application.routes.draw do
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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

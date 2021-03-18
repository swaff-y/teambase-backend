Rails.application.routes.draw do
  resources :tasks
  root :to => 'pages#home'
  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'
  resources :users
  resources :projects
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

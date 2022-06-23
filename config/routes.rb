Rails.application.routes.draw do
  root 'users#index'
  resources :users
  post 'sessions/new'
end

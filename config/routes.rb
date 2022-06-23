Rails.application.routes.draw do
  root 'users#index'
  resources :users
  post '/session', to: 'sessions#new'
end

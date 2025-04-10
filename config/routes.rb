# config/routes.rb
Rails.application.routes.draw do
  root 'gossips#index'
  
  get 'team', to: 'static_pages#team'
  get 'contact', to: 'static_pages#contact'

  # Users routes
  get '/signup', to: 'users#new', as: 'signup'
  resources :users, only: [:create]
  
  # Sessions routes
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'
  
  # Gossips routes with nested comments and likes
  resources :gossips do
    resources :comments, only: [:create]
    resources :likes, only: [:create]
  end
  
  # Delete likes
  resources :likes, only: [:destroy]
end
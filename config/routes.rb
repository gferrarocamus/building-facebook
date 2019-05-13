Rails.application.routes.draw do
  # get 'auth/:provider/callback', to: 'sessions#create'
  # get 'auth/failure', to: redirect('/')
  
  root 'posts#index'

  get 'users/:id', to: 'users#show', as: :user
  get 'users', to: 'users#index'

  resources :requests, only: [:create, :destroy, :index]
  resources :friendships, only: [:create, :destroy]
  resources :posts, only: [:new, :create, :show, :index]
  resources :comments, only: [:create]
  resources :likes, only: [:create, :destroy]

  devise_for :users, path: '/', path_names: { 
    sign_in: 'login', 
    sign_out: 'logout', 
    sign_up: 'signup' 
  }, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

end

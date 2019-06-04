Rails.application.routes.draw do
  authenticated :user do
    root to: 'posts#index', as: :authenticated_root
  end
  root to: redirect('login')

  #root 'posts#index'

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
    sign_up: 'signup',
    edit: 'edit_profile' 
  }, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  get 'privacy_policy', to: 'static_pages#policy'
  get 'terms_of_service', to: 'static_pages#terms'
end

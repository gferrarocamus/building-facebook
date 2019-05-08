Rails.application.routes.draw do
  
  # resources :users, only: [:show, :index]
  # root 'users#show'
  get 'user/:id', to: 'users#show'
  get 'users', to: 'users#index'
  
  devise_scope :user do
    root to: "users/registrations#new"
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end

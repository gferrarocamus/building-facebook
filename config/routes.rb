Rails.application.routes.draw do
  root 'users#show'

  get 'user/:id', to: 'users#show'
  get 'users', to: 'users#index'

  resources :users do
    member do
      get :senders, :receivers
    end
  end  
  
  resources :requests, only: [:create, :destroy]

  # devise_scope :user do
  #   root to: "users/registrations#new"
  # end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end

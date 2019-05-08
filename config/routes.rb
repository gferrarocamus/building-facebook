Rails.application.routes.draw do
  root 'users#index'

  get 'users/:id', to: 'users#show', as: :user
  get 'users', to: 'users#index'

  # resources :users do
  #   member do
  #     get :senders, :receivers
  #   end
  # end  
  
  resources :requests, only: [:create, :destroy]

  # devise_scope :user do
  def request_sent?(id)
    Request.exist?(sender_id: current_user.id, receiver_id: id)
  end

  def request_received?(id)
    Request.exist?(receiver_id: current_user.id, sender_id: id)
  end
  
  #   root to: "users/registrations#new"
  # end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end

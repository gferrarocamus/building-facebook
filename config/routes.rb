Rails.application.routes.draw do
  root 'devise/registrations#new'

  devise_for :users

  #resource :users, only: [:new, :create, :show, :index], path: '/registrations'
  #devise_for :users, controllers: { sessions: 'users/registrations' }
end

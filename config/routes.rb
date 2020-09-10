Rails.application.routes.draw do
  resources :labels
  namespace :admin do
    resources :users
  end
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :tasks

  root to: "sessions#new"
end

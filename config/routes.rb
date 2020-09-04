Rails.application.routes.draw do
 resources :users, module: 'admin'
 resources :users, only: [:new, :create, :show]
 resources :sessions, only: [:new, :create, :destroy]
 resources :tasks do
   collection do
     post :confirm
   end
 end

 root to: "session#new"
end

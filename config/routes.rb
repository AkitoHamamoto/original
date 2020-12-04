Rails.application.routes.draw do
  devise_for :users
  get 'users/index'
  root to: 'users#index'
  resources :users, only:[:index, :edit, :show, :update, :create, :new]
  resources :posts
  resources :rooms, only:[:new, :create, :destroy] 
  resources :boards, only:[:new, :create, :edit, :update, :destroy]
  resources :plans, only:[:new, :create, :edit, :update, :destroy]

end

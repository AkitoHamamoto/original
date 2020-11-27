Rails.application.routes.draw do
  devise_for :users
  get 'users/index'
  root to: 'users#index'
  resources :users, only:[:index, :edit, :show]
  resources :posts, only:[:index, :new, :show, :edit]
  resources :rooms, only:[:new, :create] do
    resources :messages, only: [:index, :create]
  end

end

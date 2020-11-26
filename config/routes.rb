Rails.application.routes.draw do
  devise_for :users
  get 'users/index'
  root to: 'users#index'
  resources :posts, only:[:index]

end

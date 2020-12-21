Rails.application.routes.draw do
  get 'shops/new'
  devise_for :users
  get 'users/index'
  root to: 'users#index'
  resources :users, only:[:index, :show]
  resources :posts do
    member do
      get 'search'
    end
  end
  resources :boards, only:[:new, :create, :edit, :update, :destroy]
  resources :plans, only:[:new, :create, :edit, :update, :destroy]
  resources :shops, only:[:new, :create, :edit, :update, :destroy]

end

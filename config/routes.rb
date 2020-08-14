Rails.application.routes.draw do
  # デバイス用
  devise_for :users
  root 'items#index'
  resources :items
  resources :products
end

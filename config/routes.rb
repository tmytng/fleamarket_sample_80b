Rails.application.routes.draw do
  # デバイス用
  devise_for :users
  root 'items#index'
  resources :products, only:[:new, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

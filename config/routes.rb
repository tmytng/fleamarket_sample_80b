Rails.application.routes.draw do
  # デバイス用
  devise_for :users
  root 'items#index'
  resources :products, only:[:new, :create, :show, :edit, :update]
  resources :items
  resources :credit_cards, only: [:new, :create, :show] do
    collection do
      delete 'delete', to: 'credit_cards#delete'
    end
  end
end

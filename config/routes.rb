Rails.application.routes.draw do
  # デバイス用
  devise_for :users
  root 'items#index'
  
  resources :items
  resources :products, only: [:show]
  
  resources :credit_cards, only: [:new, :create, :show] do
    collection do
      delete 'delete', to: 'credit_cards#delete'
    end
  end

end

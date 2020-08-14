Rails.application.routes.draw do
  # デバイス用
  devise_for :users
  root 'items#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  resources :credit_cards, only: [:new, :show] do
    collection do
      get 'show', to: 'credit_cards#show'
      post 'pay', to: 'credit_cards#pay'
      delete 'delete', to: 'credit_cards#delete'
    end
  end

end

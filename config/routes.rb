Rails.application.routes.draw do
  # デバイス用
  devise_for :users
  root 'items#index'
  # resources :products, only:[:new, :create, :show]
  resources :items  
  resources :credit_cards, only: [:new, :create, :show] do
    collection do
      delete 'delete', to: 'credit_cards#delete'
    end
  end
  resources :products do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
    member do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end
end

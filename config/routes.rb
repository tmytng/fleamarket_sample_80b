Rails.application.routes.draw do
  # デバイス用
  devise_for :users
  resources :items 
  root 'items#index'
  resources :products do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
    member do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end

    resources :credit_cards, only:[:show] do
      member do
        post 'pay', to: 'credit_cards#pay'
        get 'done', to: 'credit_cards#done'
      end
    end
  end
  
  resources :credit_cards, only:[:new, :create, :index] do
    member do
      delete 'delete', to: 'credit_cards#delete'
    end
  end
  resources :users, only: :show
  resources :brands, only: :show
end


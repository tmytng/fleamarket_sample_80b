Rails.application.routes.draw do
  # デバイス用
  devise_for :users
  root 'items#index'
  resources :products, only:[:new, :create, :show, :destroy] do
    resources :credit_cards, only:[:show] do
      # collection do
      #   delete 'delete', to: 'credit_cards#delete'
      # end
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

  resources :items  
  resources :users, only:[:show]
end

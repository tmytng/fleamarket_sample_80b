Rails.application.routes.draw do
  # デバイス用
  devise_for :users
  root 'items#index'
  resources :products, only:[:new, :create, :show] do
    resources :credit_cards, only:[:new, :create, :show, :index] do
      collection do
        delete 'delete', to: 'credit_cards#delete'
        get 'done', to: 'credit_cards#done'
      end

      member do
        post 'pay', to: 'credit_cards#pay'
      end
    end
  end
  resources :items  

end

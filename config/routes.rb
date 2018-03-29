Rails.application.routes.draw do
  devise_for :users
  root 'categories#index'
  resources :orders
  resources :carts do
    member do
     get 'payment'
     get 'execute'
     get 'histories'
   end
  end
  resources :categories do
    resources :products
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

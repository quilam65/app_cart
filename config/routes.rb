Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  root 'categories#index'

  resources :users, only: [:show, :update]
  resources :orders
  resources :carts do
    member do
     get 'payment'
     get 'execute'
     get 'info'
   end
  end
  resources :categories do
    resources :products
  end
  get 'histories' => 'histories#index'
  get 'histories/:id' => 'histories#show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

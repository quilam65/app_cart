Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  root 'categories#index'


  resources :orders, only: [:create, :destroy, :update]
  resources :carts, only:[:show, :index, :update] do
    member do
     get 'payment'
     get 'execute'
     get 'info'
   end
  end
  resources :categories, only:[:show, :index] do
    resources :products, only: [:show]
  end
  get 'histories' => 'histories#index'
  get 'histories/:id' => 'histories#show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

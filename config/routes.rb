Rails.application.routes.draw do
  devise_for :users
  
  get '/reset_passwords/get_info', to: 'reset_passwords#get_info'
  root 'categories#index'

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
  get 'histories/index'
  get 'histories/:id' => 'histories#show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

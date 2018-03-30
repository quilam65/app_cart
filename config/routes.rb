Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root 'categories#index'

  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end

  resources :orders
  resources :carts do
    member do
     get 'payment'
     get 'execute'
     get 'info'
   end
  end
  resources :categories, concerns: :paginatable do
    resources :products, concerns: :paginatable
  end
  get 'histories/index'
  get 'histories/:id' => 'histories#show', concerns: :paginatable


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

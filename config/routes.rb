Rails.application.routes.draw do
  devise_for :users
  resources :products
  
  get '/reset_passwords/get_info', to: 'reset_passwords#get_info'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :search_cart


  def search_cart
    $cart = current_user.carts.where(status: false).first
    if !$cart.present?
      $cart = Cart.create(status: false, user_id: current_user.id)
    end
  end
end

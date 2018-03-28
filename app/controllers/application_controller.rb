class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :search_cart


  def search_cart
    if user_signed_in?
      $cart = current_user.carts.where(status: false).limit(1).first
      if !$cart.present?
        $cart = Cart.create(status: false, user_id: current_user.id)
      end
    end
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :search_cart
  def search_cart
    if authenticate_user!
      @cart = current_user.carts.where(status: false).limit(1).first
      @cart = Cart.create(status: false, user_id: current_user.id,
                          name: current_user.name, phone: current_user.phone,
                          address: current_user.address) if @cart.blank?
    end
  end
end

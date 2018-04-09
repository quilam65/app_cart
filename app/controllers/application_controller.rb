class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :search_cart
  before_action :store_user_location!, if: :storable_location?

  def search_cart
    if current_user.present?
      @cart = current_user.carts.where(status: false).limit(1).first
      @cart = Cart.create(status: false, user_id: current_user.id) if @cart.blank?
    end
  end

  private
    def storable_location?
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
    end

    def store_user_location!
      store_location_for(:user, request.fullpath)
    end
end

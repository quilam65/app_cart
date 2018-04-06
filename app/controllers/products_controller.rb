class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
    @order = Order.find_order(@product.id,@cart.id) if @cart.present?
    @order = Order.new if @order.blank?
  end
end

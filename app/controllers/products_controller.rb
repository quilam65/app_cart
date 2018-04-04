class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
    @order = Order.where(cart_id: @cart.id, product_id: @product.id).limit(1).order('created_at DESC').first
    @order = Order.new if @order.blank?
  end
end

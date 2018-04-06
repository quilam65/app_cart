class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
    @order = Order.find_order(@product.id,@cart.id)
    @order = Order.new if @order.blank?
  end
end

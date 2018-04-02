class ProductsController < ApplicationController
  def show
    @order = Order.new
    @product = Product.find(params[:id])
  end
end

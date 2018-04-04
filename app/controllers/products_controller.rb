class ProductsController < ApplicationController
  before_action :authenticate_user!
  def show
    @order = Order.new
    @product = Product.find(params[:id])
  end
end

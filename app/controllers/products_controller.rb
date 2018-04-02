class ProductsController < ApplicationController
  before_action :authenticate_user!
  def index
    UserMailer.reset_pass('quilam.ct@gmail.com').deliver_now
  end

  def show
    @order = Order.new
    @product = Product.find(params[:id])
  end
end

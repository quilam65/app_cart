class OrdersController < ApplicationController
  before_action :assign_params, only: [:create, :update]
  before_action :get_order, only: [:update, :destroy]
  skip_before_action :verify_authenticity_token, :only => [:update]
  before_action :authenticate_user!

  def create
    @order = Order.new(@order_params)
    return redirect_to cart_path(@order.cart_id), notice: 'Add item to cart success!' if @order.save
    redirect_to category_product_path(@order.product.category, @order.product.id), alert: 'Fail'
  end

  def destroy
    return redirect_to cart_path(@order.cart_id), notice: 'Detele product from cart success!' if @order.destroy
    redirect_to cart_path(@order.cart_id), notice: 'Detele product from cart fail!'
  end

  def update
    return redirect_to cart_path(@order.cart_id), notice: 'Update quanlity success' if @order.update(@order_params)
    flash[:notice] = 'Update quanlity fail!'
  end

  private
    def get_order
      @order = Order.find(params[:id])
    end

    def assign_params
      @order_params = params.require(:order).permit(:quanlity,
                                                    :order,
                                                    :cart_id,
                                                    :product_id)
    end
end

class OrdersController < ApplicationController
before_action :assign_params, only: [:create]
before_action :get_order, only: [:update, :destroy]
skip_before_action :verify_authenticity_token, :only => [:update]

  def create
    @order = Order.where('product_id = ? AND cart_id = ?', @order_params[:product_id], @order_params[:cart_id]).limit(1).first
    if @order.present?
      @order.quanlity = @order.quanlity.to_i + @order_params[:quanlity].to_i
    else
      @order = Order.new(@order_params)
    end
    return redirect_to cart_path(@order.cart_id), notice: 'Add item to cart success!' if @order.save
    product = Product.find(@order_params[:product_id])
    redirect_to category_product_path(product.category, product.id), alert: 'Fail'
  end

  def destroy
    @order.destroy
    redirect_to cart_path(@order.cart_id)
    flash[:notice] = 'Detele product from cart success!'
  end

  def update
    if @order.update(quanlity: params[:quanlity].to_i)
      flash[:notice] = 'Update quanlity success'
    else
      flash[:notice] = 'Update quanlity fail!'
    end
  end

  private
    def get_order
      @order = Order.find(params[:id])
    end
    def assign_params
      @order_params = params.require(:order).permit(:quanlity,
                                                    :order,
                                                    :cart_id,
                                                    :product_id,
                                                    :cart_id )
    end
end

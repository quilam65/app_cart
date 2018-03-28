class OrdersController < ApplicationController
before_action :assign_params
  def create
    @order = Order.where('product_id = ? AND cart_id = ?', @order_params[:product_id], @order_params[:cart_id]).limit(1).first
    if @order.present?
      @order.quanlity = @order.quanlity.to_i + @order_params[:quanlity].to_i
    else
      @order = Order.new(@order_params)
    end
    return redirect_to cart_path(@order.cart_id), notice: 'Add item to cart success!' if @order.save
    product = Product.find(@order_params[:product_id])
    redirect_to category_product_path(product.category, product.id)
    flash[:alert] = 'Fail'
  end

  private
    def assign_params
      @order_params = params.require(:order).permit(:quanlity,
                                                    :order,
                                                    :cart_id,
                                                    :product_id,
                                                    :cart_id )
    end
end

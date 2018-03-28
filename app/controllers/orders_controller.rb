class OrdersController < ApplicationController
before_action :assign_params
  def create

    @order = Order.new(@order_params)
    return redirect_to cart_path(@order.cart_id),
    notice: 'Add item to cart success!' if @order.save!
    product = Product.find(params[:product_id])
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

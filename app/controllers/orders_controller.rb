class OrdersController < ApplicationController

  def create
    current_user.cart
    @order = Order.new(@order_params)
    return redirect_to category_product_path(Produc.find(params[:product_id]), params[:product_id]),
    notice: 'Add item to cart success!' if @order.save!
    redirect_to category_product_path(Produc.find(params[:product_id])
    flash[:alert] ='Fail'
  end
  private
    def assign_params
      @order_params = params.require(:order).permit(:quanlity
                                                  , :order
                                                  , :cart_id
                                                  , :product_id )
    end
end

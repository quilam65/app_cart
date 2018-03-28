class CartsController < ApplicationController
  before_action :sum_price
  def show
  end

  private
    def sum_price
      @cart = Cart.find(params[:id])
      @orders = @cart.orders.includes(:product)
      @sum = 0
      @orders.each do |order|
        @sum = @sum + order.quanlity * order.product.price
      end
      @cart.update(total_amount_cents: @sum)
    end
end

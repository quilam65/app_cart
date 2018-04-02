class HistoriesController < ApplicationController

  def index
    # @payment_histories = PayPal::SDK::REST::Payment.all( :count => 10 )
    # @payment_histories = @payment_histories.payments
    @carts = current_user.carts.finished
  end

  def show
    @cart = Cart.find(params[:id])
  end

end

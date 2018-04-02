class HistoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    # @payment_histories = PayPal::SDK::REST::Payment.all( :count => 10 )
    # @payment_histories = @payment_histories.payments
    @carts = current_user.carts.where(status: true).page(params[:page]).per(5)
  end

  def show
    @cart = Cart.find(params[:id])
  end

end

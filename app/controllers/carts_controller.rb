class CartsController < ApplicationController
  before_action :get_product
  before_action :sum_price, only: [:show]
  def show
  end
  def index
  end

  def payment
    @payment = PayPal::SDK::REST::Payment.new({
      :intent => "sale",
      :payer => {
        :payment_method => "paypal" },
      :redirect_urls => {
        :return_url => 'http://localhost:3000' + payment_cart_path(params[:id]),
        :cancel_url => 'http://localhost:3000' + cart_path(params[:id]) },
      :transactions => [ {
        :amount => {
          :total => @cart.total_amount_cents,
          :currency => "USD" },
        :description => "creating a payment" } ] } )

    if @payment.create
      @payment.id     # Payment Id
    else
      @payment.error  # Error Hash
    end
    if !params[:token].nil? && !params[:PayerID].nil?
        @cart.update(payment_id: params[:paymentId], token_payment: params[:token], payer_id: params[:PayerID])
    end
  end

  def execute
    @payment = PayPal::SDK::REST::Payment.find(@cart.payment_id)
    if @payment.execute( :payer_id => @cart.payer_id   )
      @cart.update(status: true)
      flash[:notice] = 'Payment success!'
    else
       flash[:notice] = @payment.error # Error Hash
    end
  end

  def histories
    @payment_histories = PayPal::SDK::REST::Payment.all( :count => 10 )
  end

  private
    def get_product
      @cart = Cart.find(params[:id])
    end
    def sum_price
      @orders = @cart.orders.includes(:product)
      @sum = 0
      @orders.each do |order|
        @sum = @sum + order.quanlity * order.product.price
      end
      @cart.update(total_amount_cents: @sum)
    end
end

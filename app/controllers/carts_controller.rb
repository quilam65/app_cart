class CartsController < ApplicationController
  before_action :get_product
  before_action :sum_price, only: [:show]
  def show
    # redirect to history hshow cart
    if @cart.status==true
      redirect_to "/histories/#{@cart.id}"
    end
  end

  def info
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

    @payment.create

    if params[:token].present? && params[:PayerID].present?
        @cart.update(payment_id: params[:paymentId], token_payment: params[:token], payer_id: params[:PayerID])
        redirect_to execute_cart_path(id: @cart.id, paymentId:params[:paymentId])
    end
  end

  def update
    @assigns_cart = params.require(:cart).permit(:name, :phone, :address)

    return redirect_to payment_cart_path(@cart.id) if @cart.update(@assigns_cart)
    redirect_to info_cart_path(@cart.id), alert: 'Input not empty!'
  end

  def execute
    @payment = PayPal::SDK::REST::Payment.find(@cart.payment_id)
    if @payment.execute( :payer_id => @cart.payer_id)
      return redirect_to root_path, notice: 'Payment success!' if @cart.update(status: true)
    end
    redirect_to cart_path(@cart), notice: @payment.error # Error Hash
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

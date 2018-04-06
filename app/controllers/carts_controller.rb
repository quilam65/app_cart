class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_product
  before_action :sum_price, only: [:show]
  def show
    redirect_to "/histories/#{@cart.id}" if @cart.status==true # redirect to history hshow cart
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
    return redirect_to execute_cart_path(id: @cart.id, paymentId:params[:paymentId]) if @cart.update(payment_id: params[:paymentId], token_payment: params[:token], payer_id: params[:PayerID]) if params[:PayerID].present?
  end

  def update
    @assigns_cart = params.require(:cart).permit(:name, :phone, :address)
    return redirect_to payment_cart_path(@cart.id) if @cart.update(@assigns_cart) and assigns_blank!
    redirect_to info_cart_path(@cart.id), alert: 'Name, Phone, Address can\'t empty!'
  end

  def execute
    @payment = PayPal::SDK::REST::Payment.find(@cart.payment_id)
    return redirect_to root_path, notice: 'Payment success!' if (@cart.update(status: true)) && (@payment.execute( :payer_id => @cart.payer_id))
    redirect_to cart_path(@cart), notice: @payment.error # Error Hash
  end

  private

    def assigns_blank!
      return false if @assigns_cart[:name].blank? or @assigns_cart[:address].blank? or @assigns_cart[:phone].blank?
      return true
    end


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

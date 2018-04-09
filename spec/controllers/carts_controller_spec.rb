require 'rails_helper'
RSpec.describe CartsController, type: :controller do
  let(:cart) { create(:cart) }
  login_admin

  describe 'show' do
    it 'get information product' do
      get :show, params: { id: cart.id }
      expect(assigns(:cart).id).to eq cart.id
    end
  end

  describe 'info' do
    it 'add information' do
      get :info, params: { id: cart.id }
      expect(assigns(:cart).id).to eq cart.id
    end
  end

  describe 'payment' do
    context 'buy' do
      it 'create payment' do
        payment = PayPal::SDK::REST::Payment.new({
          :intent => "sale",
          :payer => {
            :payment_method => "paypal" },
          :redirect_urls => {
            :return_url => 'http://localhost:3000' + payment_cart_path(cart.id),
            :cancel_url => 'http://localhost:3000' + cart_path(cart.id) },
          :transactions => [ {
            :amount => {
              :total => cart.total_amount_cents,
              :currency => "USD" },
            :description => "creating a payment" } ] } )

        payment.create
        expect(payment.error).to be_nil
        expect(payment.id).not_to be_nil
        expect(payment.approval_url).not_to be_nil
        expect(payment.token).not_to be_nil
      end
    end
    it 'get token' do
      get :payment, params: { id: cart.id }
      expect(assigns(:cart).id).to eq cart.id
    end
  end

  describe 'update' do
    context 'success' do
      cart_b = { name: 'qui lam', phone: '123444', address: '57 dien bien phu' }
      it 'update information buyer' do
        post :update, params: { id: cart.id, cart: cart_b }
        expect(assigns(:cart).name).to eq cart_b[:name]
        expect(response).to redirect_to payment_cart_path(cart.id)
      end
    end

    context 'fail' do
      cart_b = { name: '', phone: '123444', address: '57 dien bien phu' }
      it 'update information buyer' do
        post :update, params: { id: cart.id, cart: cart_b }
        expect(response).to redirect_to info_cart_path(cart.id)
      end
    end
  end

end

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
        expect(payment).to be_success
      end
    end

    it 'get token' do
      get :payment, params: { id: cart.id }
      expect(assigns(:cart).id).to eq cart.id
    end

    it "List" do
      payment_history = PayPal::SDK::REST::Payment.all( "count" => 5 )
      expect(payment_history.error).to be_nil
      expect(payment_history.count).to eql 5
    end

    it "Find" do
      payment_history =  PayPal::SDK::REST::Payment.all( "count" => 1 )
      payment =  PayPal::SDK::REST::Payment.find(payment_history.payments[0].id)
      expect(payment.error).to be_nil
    end
  end

  describe "Validation", :integration => true do

    it "Create with empty values" do
      payment = PayPal::SDK::REST::Payment.new
      expect(payment.create).to be_falsey
    end

    it "Find with invalid ID" do
      expect {
        payment = PayPal::SDK::REST::Payment.find("Invalid")
      }.to raise_error PayPal::SDK::Core::Exceptions::ResourceNotFound
    end

    it "Find with nil" do
      expect{
        payment = PayPal::SDK::REST::Payment.find(nil)
      }.to raise_error ArgumentError
    end

    it "Find with empty string" do
      expect{
        payment = PayPal::SDK::REST::Payment.find("")
      }.to raise_error ArgumentError
    end

    it "Find record with expired token" do
      expect {
        PayPal::SDK::REST::Payment.api.token
        PayPal::SDK::REST::Payment.api.token.sub!(/^/, "Expired")
        PayPal::SDK::REST::Payment.all(:count => 1)
      }.not_to raise_error
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

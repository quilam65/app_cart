require 'rails_helper'
RSpec.describe OrdersController, type: :controller do
  login_admin
  let(:cart) { create(:cart, user_id: @current_user.id) }
  let!(:orders) { create_list(:order, 3, cart_id: cart.id) }
  let!(:product) { create(:product) }
  describe 'create' do
    it 'add product to cart' do
      order =  { quanlity: 1, order: 'becarful', product_id: product.id, cart_id: cart.id}
      get :create, params: {order: order}
      expect(assigns(:order).quanlity).to eq order[:quanlity]
      expect(assigns(:order).product_id).to eq order[:product_id]
      expect(assigns(:order).order).to eq order[:order]
    end
  end

  describe 'delete' do
    it 'delete o order' do
      expect{
        delete :destroy, params: { id: orders.first.id }
      }.to change(Order, :count).by(-1)
    end
  end

  describe 'update' do
    quanlity = 4
    it 'update quanlity' do
      put :update, params: { id: orders.first.id, quanlity: quanlity }
      expect(assigns(:order).quanlity).to eq quanlity
    end
  end
end

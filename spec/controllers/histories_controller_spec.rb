require 'rails_helper'
RSpec.describe HistoriesController, type: :controller do
  login_admin
  let!(:carts) { create_list(:cart, 3, user_id: @current_user.id) }
  let(:orders) { create_list(:product, 5, cart_id: carts.first.id) }

  describe 'index' do
    it 'get a list carts' do
      get :index
      expect(assigns(:carts).size).to eq carts.size
    end

    it 'sort cart' do
      get :index
      expect(assigns(:carts).third.created_at).to eq carts.first.created_at
      expect(assigns(:carts).second.created_at).to eq carts.second.created_at
      expect(assigns(:carts).first.created_at).to eq carts.third.created_at
    end
  end

  describe 'show' do
    it 'get a cart detail' do
      get :show, params: { id: carts.first.id }
      expect(assigns(:cart).id).to eq carts.first.id
    end
  end
end

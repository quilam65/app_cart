require 'rails_helper'
RSpec.describe HistoriesController, type: :controller do
  login_admin
  let!(:carts) { create_list(:cart, 5, user_id: User.last.id) }
  let(:orders) { create_list(:product, 5, cart_id: carts.first.id) }

  describe 'index' do
    it 'get a list carts' do
      get :index
      expect(assigns(:carts).size).to eq carts.size
    end
  end

  describe 'show' do
    it 'get a cart detail' do

      get :show, params: { id: carts.first.id }
      expect(assigns(:cart).id).to eq carts.first.id

    end
  end
end

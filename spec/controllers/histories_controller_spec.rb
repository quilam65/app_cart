require 'rails_helper'
RSpec.describe HistoriesController, type: :controller do
  login_admin
  let!(:carts) { create_list(:cart, 3, user_id: @current_user.id) }
  let(:orders) { create_list(:product, 5, cart_id: carts.first.id) }

  def do_request(page, size)
    get :index, params: { page: page}
    expect(assigns(:carts).size).to eq size.to_i
  end

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

  context 'kaminari' do
    let!(:carts) { create_list(:cart, 12, user_id: @current_user.id) }
    it 'page 1' do
      do_request(1,5)
    end
    it 'page 2' do
      do_request(2,5)
    end
    it 'page 3' do
      do_request(3,2)
    end
  end

end

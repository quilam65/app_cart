require 'rails_helper'
RSpec.describe ProductsController, type: :controller do
  let(:product) { create(:product) }
  login_admin
  describe 'show' do
    it 'get information product' do
      get :show, params: { id: product.id, category_id: product.category_id }
      expect(assigns(:product).id).to eq product.id
    end
  end
end

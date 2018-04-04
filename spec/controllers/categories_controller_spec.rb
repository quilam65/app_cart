require 'rails_helper'
RSpec.describe CategoriesController, type: :controller do

  let!(:categories) { create_list(:category,3) }
  let!(:products) { create_list(:product, 3, category_id: categories.first.id) }
  login_admin

  describe 'show' do
    it 'get category' do
      get :show, params: { id: categories.first.id }
      expect(assigns(:category).id).to eq categories.first.id
    end

    it 'sort product' do
      get :show, params: { id: categories.first.id }
      expect(assigns(:products).third.id).to eq products.first.id
      expect(assigns(:products).second.id).to eq products.second.id
      expect(assigns(:products).first.id).to eq products.third.id
    end
  end

  describe 'index' do
    it 'get a list categories' do
      get :index
      expect(assigns(:categories).size).to eq categories.size
    end

    it 'sort category' do
      get :index
      expect(assigns(:categories).third.id).to eq categories.first.id
      expect(assigns(:categories).second.id).to eq categories.second.id
      expect(assigns(:categories).first.id).to eq categories.third.id
    end
  end
end

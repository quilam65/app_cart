require 'rails_helper'
RSpec.describe CategoriesController, type: :controller do

  let!(:category) { create(:category) }
  let!(:categories) { create_list(:category,5) }
  let!(:product) { create_list(:product, 5, category_id: category.id) }
  login_admin

  describe 'show' do
    it 'get category' do
      get :show, params: { id: category.id }
      expect(assigns(:category).id).to eq category.id
    end
  end

  describe 'index' do
    it 'get a list categories' do
      get :index
      expect(assigns(:categories).size).to eq categories.size
    end
  end
end

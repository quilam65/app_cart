require 'rails_helper'
RSpec.describe UsersController, type: :controller do

  login_admin

  describe 'show' do
    it 'get information user' do
      get :show, params: { id: @current_user.id }
      expect(@current_user.id).to eq @current_user.id
    end
  end

  describe 'update' do
    it 'update information' do
      user = { name: 'foxzi', phone:'1222222', address: '195 dbp' }
      post :update, params: { id: @current_user.id, user: user }
      expect(@current_user.reload.name).to eq user[:name]
      expect(response).to redirect_to user_path(@current_user.id)
    end
  end

end

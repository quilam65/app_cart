require 'rails_helper'
require 'features/sign_up'
describe 'View cart', type: :feature do
  sign_up

  let!(:product) { create(:product) }
  let!(:cart) { create(:cart, status: false, user_id: @current_user.id) }
  it 'show' do
    visit root_path
    expect(page).to have_content 'Cart'
    click_on 'Cart'
    expect(page).to have_content 'My cart'
  end

  context 'success' do
    it 'info' do
      visit info_cart_path(cart.id)
      expect(page).to have_content 'Infomation cart'
      fill_in 'cart[name]', with: 'qui lam'
      fill_in 'cart[phone]', with: '992929'
      fill_in 'cart[address]', with: '57 dien bien'
      click_on 'Update Cart'
      expect(page).to have_content 'qui lam'
      expect(page).to have_content '992929'
    end
  end

  context 'fail' do
    it 'info' do
      visit info_cart_path(cart.id)
      expect(page).to have_content 'Infomation cart'
      fill_in 'cart[name]', with: ''
      fill_in 'cart[phone]', with: '992929'
      fill_in 'cart[address]', with: '57 dien bien'
      click_on 'Update Cart'
      expect(page).to have_content 'Name, Phone, Address can\'t empty!'
    end
  end




end

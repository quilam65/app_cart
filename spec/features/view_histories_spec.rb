require 'rails_helper'
require 'features/sign_up'
describe 'View history', type: :feature do
  sign_up

  let!(:cart) { create(:cart) }
  let!(:order) { create(:order, cart_id: cart.id) }
  let!(:carts) { create_list(:cart, 5, user_id: @current_user.id) }
  context 'show' do
    it 'show' do
      visit '/histories/' + cart.id.to_s
      expect(page).to have_content 'My history'
      expect(page).to have_content cart.phone
      expect(page).to have_content cart.address
      expect(page).to have_content cart.name
    end
  end

  context 'show product in hisstory' do
    it 'show' do
      visit '/histories/' + cart.id.to_s
      expect(page).to have_content 'My history'
      expect(page).to have_content cart.phone
      click_on cart.orders.first.product.title
      expect(page).to have_content cart.orders.first.product.title
    end
  end


  it 'index' do
    visit '/histories'
    expect(page).to have_content 'Histories'
    expect(page).to have_content carts[0].name
    expect(page).to have_content carts[0].address
  end

end

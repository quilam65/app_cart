require 'rails_helper'
require 'features/sign_up'
describe 'Order', type: :feature do
  sign_up

  let!(:product) { create(:product) }
  let!(:cart) { create(:cart, status: false, user_id: @current_user.id) }
  let!(:order) { create(:order, cart_id: cart.id, product_id: product.id) }

  it 'create' do
    visit category_product_path(product.category_id, product.id)
    find('.btn-success.form-control').click
    expect(page).to have_content 'Add item to cart success!'
    expect(page).to have_content 'My cart'
  end

  it 'update' do
    visit cart_path(cart.id)
    expect(page).to have_link product.title
    click_on product.title
    fill_in 'order[quanlity]', with: 10
    fill_in 'order[order]', with: 'careful'
    find('.btn-success.form-control').click
    expect(page).to have_content 'My cart'
  end

  it 'destroy' do
    visit cart_path(cart.id)
    expect(page).to have_link product.title
    find('.btn-danger.btn-sm').click
    expect(page).to have_content 'Detele product from cart success!'
  end

end

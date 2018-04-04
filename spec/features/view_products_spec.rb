require 'rails_helper'
require 'features/sign_up'
describe 'View Product', type: :feature do
  sign_up

  let!(:product) { create(:product) }
  it 'show' do
    visit category_product_path(category_id: product.category, id: product.id)
    expect(page).to have_content product.title
    fill_in 'order[quanlity]', with: 1
    fill_in 'order[order]', with: 'careful'
    click_on 'Create Order'
    expect(page).to have_content 'My cart'
  end
  
end

require 'rails_helper'
require 'features/sign_up'
describe 'View history', type: :feature do
  sign_up

  let!(:cart) { create(:cart) }
  let!(:carts) { create_list(:cart, 5, user_id: @current_user.id) }

  it 'show' do
    visit '/histories/' + cart.id.to_s
    expect(page).to have_content 'My history'
    expect(page).to have_content cart.phone
    expect(page).to have_content cart.address
    expect(page).to have_content cart.name
  end

  it 'index' do
    visit '/histories'
    expect(page).to have_content 'Histories'
    expect(page).to have_content carts[0].name
    expect(page).to have_content carts[0].address
  end

end

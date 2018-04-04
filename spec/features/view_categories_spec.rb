require 'rails_helper'
require 'features/sign_up'
describe 'View Categories', type: :feature do
  sign_up

  let!(:categories) { create_list(:category,5) }
  let!(:products) { create_list(:product, 5, category_id: categories.first.id) }

  it 'index' do
    visit root_path
    expect(page).to have_link categories.first.title
    expect(page).to have_link categories.second.title
    expect(page).to have_link categories.third.title
    expect(page).to have_link 'Home'
  end

  it 'show' do
    visit category_path(categories.first.id)
    expect(page).to have_content categories.first.products[0].title
    expect(page).to have_content categories.first.products[1].title
    expect(page).to have_content categories.first.products[2].title
    expect(page).to have_content categories.first.products[3].title
    expect(page).to have_content categories.first.products[4].title
  end

end

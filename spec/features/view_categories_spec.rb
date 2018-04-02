require 'rails_helper'
require 'features/sign_up'
describe 'View Categories', type: :feature do
  sign_up

  let!(:categories) { create_list(:category,5) }
  it 'index' do
    visit root_path
    expect(page).to have_content categories.first.title
    expect(page).to have_content categories.second.title
    expect(page).to have_content categories.third.title
    expect(page).to have_link 'Home'
  end

end

require 'rails_helper'
require 'features/sign_up'
describe 'View information', type: :feature do
  sign_up

  it 'show' do
    visit root_path
    expect(page).to have_link 'Me'
    click_on 'Me'
    expect(page).to have_content 'Email'
    expect(page).to have_content 'Name'
  end

  it 'show' do
    visit root_path
    expect(page).to have_link 'Me'
    click_on 'Me'
    fill_in 'user[name]', with: 'fox zi 1'
    fill_in 'user[name]', with: '0939787505'
    fill_in 'user[name]', with: '195 dbphu'
    click_on 'Update'
    expect(page).to have_content 'Update information success!'
  end


end

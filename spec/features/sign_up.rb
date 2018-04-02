
def sign_up
  before(:each) do
    user =  FactoryBot.build(:user)
    visit '/users/sign_up'
    expect(page).to have_content 'Sign up'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    fill_in 'user[password_confirmation]', with: user.password
    click_on 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
end

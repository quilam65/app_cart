module ControllerAuth
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      # request.session[:user] = user.id
    end
  end
end

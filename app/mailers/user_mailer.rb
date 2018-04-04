class UserMailer < ApplicationMailer
  default from: "anhqui1995@gmail.com"
  layout 'mailer'

  def reset_pass(email,pass)
    @user = User.find_by_email(email)
    @pass = pass
    @url  = 'http://localhost:3000/users/sign_in'
    mail(to: email, subject: 'Reset password')
  end

end

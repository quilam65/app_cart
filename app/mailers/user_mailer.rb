class UserMailer < ApplicationMailer
  default from: "anhqui1995@gmail.com"
  layout 'mailer'

  def reset_pass(email)
    @user = User.find_by_email(email)
    @url  = 'http://example.com/login'
    mail(to: email, subject: 'Reset password')
  end

end

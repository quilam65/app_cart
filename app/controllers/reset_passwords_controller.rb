class ResetPasswordsController < ApplicationController
  def get_info
    @email = params[:email]
    if @email.present?
      @user = User.find_by_email(@email)
      if @user.present?
        pass = 'abcd@1234'
        @user.update(password: pass, password_confirmation: pass)
        UserMailer.reset_pass(@email,pass).deliver_now
        flash[:notice] = 'Password send to your email'
        redirect_to root_path
      else
        flash[:alert] = 'Email not found'
        render :get_info
      end

    end
  end
end

class UsersController < ApplicationController
  def show
  end

  def update
    @params = params.require(:user).permit(:name, :phone, :address)
    return redirect_to user_path(current_user), notice: 'Update information success!' if current_user.update!(@params)
  end
end

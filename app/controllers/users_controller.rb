class UsersController < ApplicationController
  layout 'before_login_layout'
  def new
    @user = User.new
  end

  def create
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :term_of_service)
  end
end

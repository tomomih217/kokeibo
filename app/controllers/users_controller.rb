class UsersController < ApplicationController
  layout 'before_login_layout'
  def new
    @form = UserForm.new
  end

  def create
    @form = UserForm.new(user_params)
    if @form.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :term_of_service)
  end
end

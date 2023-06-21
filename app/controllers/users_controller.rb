class UsersController < ApplicationController
  layout 'before_login_layout'
  skip_before_action :delete_session, only: %i[create]
  after_action :delete_session, only: %i[create]

  def new
    @form = UserForm.new
  end

  def confirm
    @form = UserForm.new(user_params)
    
    if @form.valid?
      session[:user_params] = user_params
    else
      render :new
    end
  end

  def create
    @form = UserForm.new(session[:user_params])
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

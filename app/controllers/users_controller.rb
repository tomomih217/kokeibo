class UsersController < ApplicationController
  layout 'before_login_layout'
  skip_before_action :delete_session, only: %i[create]
  after_action :delete_session, only: %i[create]

  def new
    @form = UserForm.new
  end

  def confirm
    @form = UserForm.new(user_params)
    is_duplicated = User.duplicated?(user_params[:name])
    
    if @form.invalid? || is_duplicated
      flash.now[:notice] = 'そのユーザー名は使用されています。'
      render :new
    end
    session[:user_params] = user_params
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

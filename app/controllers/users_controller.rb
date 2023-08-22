class UsersController < ApplicationController
  layout 'before_login_layout'
  skip_before_action :require_login, only: %i[new confirm create complete]
  skip_before_action :delete_session, only: %i[create]
  skip_before_action :get_current_child
  after_action :delete_session, only: %i[create]

  def new
    @form = UserForm.new
  end

  def confirm
    @form = UserForm.new(user_params)
    is_duplicated = User.duplicated?(user_params[:name])

    if @form.invalid? || is_duplicated
      flash.now[:danger] = 'そのユーザー名は使用されています。' if is_duplicated
      render :new
    end
    session[:user_params] = user_params
  end

  def create
    @form = UserForm.new(session[:user_params])
    if @form.save
      redirect_to users_complete_path
    else
      render :new
    end
  end

  def complete; end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :child_name, :child_stage, :term_of_service)
  end
end

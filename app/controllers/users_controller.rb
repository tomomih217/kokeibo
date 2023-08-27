class UsersController < ApplicationController
  layout 'before_login_layout', only: %i[new confirm create]
  layout 'after_login_layout', only: %i[show edit update destroy]
  skip_before_action :require_login, only: %i[new confirm create complete]
  skip_before_action :delete_session, only: %i[create destroy]
  skip_before_action :get_current_child, only: %i[new confirm create]
  after_action :delete_session, only: %i[create destroy]

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

  def show
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(current_user), success: '会員情報を更新しました。'
    else
      flash.now[:danger] = '編集に失敗しました'
      render :edit
    end
  end

  def destroy
    User.destroy(current_user.id)
    redirect_to login_path, success: '退会が完了しました。ご利用ありがとうございました。'
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :child_name, :child_stage, :term_of_service)
  end
end

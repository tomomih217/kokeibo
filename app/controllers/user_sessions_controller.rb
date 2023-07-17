class UserSessionsController < ApplicationController
  skip_before_action :require_login
  skip_before_action :set_current_child

  layout 'before_login_layout'
  def new
    @user = User.new
  end

  def create
    @user = login(params[:user][:name], params[:user][:password])
    if @user
      session[:child_id] = @user.children[0].id
      redirect_to mypage_path, success: "こんにちは、#{@user.name}さん"
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    forget_me!
    session.delete(:child_id)
    logout
    redirect_to login_url, flash: { success: 'ログアウトに成功しました' }
  end
end

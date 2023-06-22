class UserSessionsController < ApplicationController
  layout 'before_login_layout'
  def new
    @user = User.new
  end

  def create
    @user = login(params[:user][:name], params[:user][:password])
    if @user
      redirect_back_or_to mypage_path, success: "こんにちは、#{@user.name}さん"
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    forget_me!
    logout
    redirect_to login_url, flash: { success: 'ログアウトに成功しました' }
  end
end

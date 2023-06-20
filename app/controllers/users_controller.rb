class UsersController < ApplicationController
  layout 'before_login_layout'
  def new
    @user = User.new
  end

  def create
    redirect_to root_path
  end
end

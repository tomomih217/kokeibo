class UserSessionsController < ApplicationController
  layout 'before_login_layout'
  def new
    @user = User.new
  end

  def create
  end

  def destroy
  end
end

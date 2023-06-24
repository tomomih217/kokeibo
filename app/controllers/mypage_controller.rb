class MypageController < ApplicationController
  layout 'after_login_layout'
  def show
    @user = current_user
  end
end

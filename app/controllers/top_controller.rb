class TopController < ApplicationController
  skip_before_action :require_login
  skip_before_action :get_current_child

  def index
    redirect_to mypage_path if current_user
  end
end

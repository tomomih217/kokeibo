class ApplicationController < ActionController::Base
  before_action :delete_session
  before_action :require_login
  before_action :get_current_child
  add_flash_types :success, :info, :warning, :danger

  def delete_session
    session.delete(:user_params) if session[:user_params]
  end

  def get_current_child
    @child = Child.find(session[:child_id])
  end
end

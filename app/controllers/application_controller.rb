class ApplicationController < ActionController::Base
  before_action :delete_session
  add_flash_types :success, :info, :warning, :danger

  def delete_session
    session.delete(:user_params) if session[:user_params]
  end
end

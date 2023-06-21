class ApplicationController < ActionController::Base
  before_action :delete_session

  def delete_session
    session.delete(:user_params) if session[:user_params]
  end
end

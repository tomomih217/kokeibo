class TopController < ApplicationController
  skip_before_action :require_login
  skip_before_action :get_current_child

  def index; end
end

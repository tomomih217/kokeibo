class TopController < ApplicationController
  skip_before_action :require_login
  skip_before_action :set_current_child

  def index
  end
end

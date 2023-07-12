class PlansController < ApplicationController
  layout 'after_login_layout'
  def index
    @plans = current_user.current_child.plans
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end
end

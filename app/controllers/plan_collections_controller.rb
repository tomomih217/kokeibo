class PlanCollectionsController < ApplicationController
  layout 'after_login_layout'
  def index
    @plans = current_user.current_child.plans
  end

  def new
    @plan_collection = PlanCollection.new
  end

  def create
  end

  def edit
  end

  def update
  end
end

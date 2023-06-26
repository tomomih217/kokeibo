class SaveSchedulesController < ApplicationController
  layout 'after_login_layout'
  def new
    @save_schedule = SaveSchedule.new
  end

  def create
  end
end

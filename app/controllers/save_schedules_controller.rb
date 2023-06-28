class SaveSchedulesController < ApplicationController
  layout 'after_login_layout'
  def new
    @save_schedule = SaveSchedule.new
  end

  def create
    child = current_user.children.first
    @save_schedule = SaveSchedule.new(save_schedule_params.merge(child: child))
    if @save_schedule.save
      redirect_to mypage_url, success: '積立計画を登録しました'
    else
      flash.now[:danger] = '登録に失敗しました'
      render :new
    end
  end

  private

  def save_schedule_params
    params.require(:save_schedule).permit(:age_from, :age_to, :amount)
  end
end

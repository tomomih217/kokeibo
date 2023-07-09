class SaveSchedulesController < ApplicationController
  layout 'after_login_layout'
  def new
    @form = SaveScheduleForm.new
  end

  def create
    @form = SaveScheduleForm.new(save_schedule_params)
    if @form.save(current_user)
      redirect_to mypage_url, success: '積立計画を登録しました'
    else
      flash.now[:danger] = '登録に失敗しました'
      render :new
    end
  end

  private

  def save_schedule_params
    params.require(:save_schedule_form).permit(save_schedules_attributes: [:age_from, :age_to, :amount])
  end
end

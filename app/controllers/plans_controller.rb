class PlansController < ApplicationController
  layout 'after_login_layout'
  def index
    @plans = current_user.current_child.plans
  end

  def new
    @form = PlanForm.new
  end

  def create
    @form = PlanForm.new(plan_form_params)
    if @form.save
      redirect_to child_plans_path, success: '入金設定しました'
    else
      flash.now[:danger] = '入力項目を確認してください'
      render :new
    end
  end

  def edit
  end

  def update
  end

  private

  def plan_form_params
    params.require(:plan_form).permit(
      plans_attributes: [:item, :amount, :payment_day, :is_auto, :child_id]
    )
  end
end

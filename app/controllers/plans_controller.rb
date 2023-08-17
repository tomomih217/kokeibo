class PlansController < ApplicationController
  layout 'after_login_layout'
  def index ;end

  def new
    @form = PlanForm.new
  end

  def create
    @form = PlanForm.new(plan_form_params)
    if @form.save
      redirect_to child_plans_path, success: '積立情報設定しました'
    else
      flash.now[:danger] = '入力項目を確認してください'
      render :new
    end
  end

  def edit
    @form = PlanForm.new
    @form.plans = edit_plans
  end

  def update
    @form = PlanForm.new(plan_form_params)
    plan_ids = @child.plans.pluck(:id)
    if @form.save
      plan_ids.each do |id|
        Plan.destroy(id)
      end
      redirect_to child_plans_path, success: '積立情報設定を編集しました'
    else
      flash.now[:danger] = '入力項目を確認してください'
      render :edit
    end
  end

  def destroy
    plan = @child.plans.find(params[:id])
    plan.destroy!
    redirect_to child_plans_path(@child), success: '積立情報設定を削除しました'
  end

  private

  PLANS_COUNT = 3

  def plan_form_params
    params.require(:plan_form).permit(
      plans_attributes: %i[item amount payment_day is_auto child_id]
    )
  end

  def edit_plans
    plans = @child.plans
    if plans.length != PLANS_COUNT
      plans.concat(Array.new(PLANS_COUNT - plans.length) { Plan.new })
    end
    plans
  end
end

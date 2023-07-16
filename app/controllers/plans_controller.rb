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
    @form = PlanForm.new
    @form.plans = edit_plans
  end

  def update
    @form = PlanForm.new(plan_form_params)
    plan_ids = current_user.current_child.plans.pluck(:id)
    if @form.save
      plan_ids.each do |id|
        Plan.destroy(id)
      end
      redirect_to child_plans_path, success: '入金設定を編集しました'
    else
      flash.now[:danger] = '入力項目を確認してください'
      render :edit
    end
  end

  def destroy
    plan = current_user.current_child.plans.find(params[:id])
    plan.destroy!
    redirect_to child_plans_path(current_user.current_child), success: '入金設定を削除しました'
  end

  private

  def plan_form_params
    params.require(:plan_form).permit(
      plans_attributes: [:item, :amount, :payment_day, :is_auto, :child_id]
    )
  end

  def edit_plans
    plans = current_user.current_child.plans
    if plans.length != 3
      (3 - plans.length).times do
        plans.push(Plan.new)
      end
    end
    plans
  end
end

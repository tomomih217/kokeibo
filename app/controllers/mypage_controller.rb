class MypageController < ApplicationController
  layout 'after_login_layout'
  def show
    @savings_datas = @child.payments.group(:item).sum(:amount)
    @each_stage_cost = @child.result.each_stage_cost if @child.result.present?
  end
end

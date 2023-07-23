class MypageController < ApplicationController
  layout 'after_login_layout'
  def show
    @savings_datas = @child.payments.group(:item).sum(:amount)
  end
end

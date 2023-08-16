class ChildrenController < ApplicationController
  layout 'after_login_layout'
  def new
    @new_child = Child.new
  end

  def create
    @new_child = Child.new(child_params)
    if @new_child.save
      redirect_to mypage_url, success: 'お子様の情報を新規登録しました'
    else
      render :new
    end
  end

  private

  def child_params
    params.require(:child).permit(:name, :stage).merge(user: current_user)
  end
end

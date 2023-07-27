class ResultsController < ApplicationController
  layout 'after_login_layout'
  def index
    @result = @child.result
  end

  def create
    @result = Result.new(result_params)
    if @result.save
      redirect_to mypage_path, success: '希望進路を登録しました'
    else
      flash.now[:danger] = '登録に失敗しました'
      render new_simulation_path
    end
  end

  def update
    @result = @child.result.find(params[:id])
    if @result.update(result_params)
      redirect_to mypage_path, success: '希望進路を編集しました'
    else
      flash.now[:danger] = '登録に失敗しました'
    end
  end

  private

  def result_params
    params.require(:result).permit(
      :id,
      :age,
      :nursery_school,
      :kindergarten,
      :primary_school,
      :junior_high_school,
      :high_school,
      :university,
      :living_alone_funds
    ).merge(child: @child)
  end
end

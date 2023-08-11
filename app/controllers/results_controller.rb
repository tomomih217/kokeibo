class ResultsController < ApplicationController
  layout 'after_login_layout'
  def index
    @result = @child.result
    @cost_datas = @result.cost_datas_hash if @result
    @cost_by_ages = @result.cost_datas_by_age if @result
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
    @result = @child.result
    if @result.update(result_params)
      redirect_to mypage_path, success: '希望進路を編集しました'
    else
      flash.now[:danger] = '編集に失敗しました'
      render edit_simulation_path(@result)
    end
  end

  private

  def result_params
    params.require(:result).permit(
      :id,
      :age,
      :nursery_school,
      :from_age_for_nursery_school,
      :kindergarten,
      :primary_school,
      :junior_high_school,
      :high_school,
      :university,
      :living_alone_funds
    ).merge(child: @child)
  end
end

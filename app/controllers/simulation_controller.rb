class SimulationController < ApplicationController
  layout 'after_login_layout'
  def new
    @result = Result.new
  end

  def create
  end

  def result
    @result = Result.new(Result.params_format(result_params))
    if @result.invalid?
      @errors = @result.errors.full_messages
      render :new
    else
      @result_params = Result.params_format(result_params)
    end
  end

  private

  def result_params
    params.require(:result).permit(
      :age,
      :nursery_school,
      :kindergarten,
      :primary_school,
      :junior_high_school,
      :high_school,
      :university,
      :living_alone_funds
    ).merge(child: current_user.children[0])
  end
end

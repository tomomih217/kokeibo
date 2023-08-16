class ChildDecorator < ApplicationDecorator
  delegate_all

  def hold_amount(age)
    (culculated_amount(age) - result.cost_until_age(age)).to_s(:delimited)
  end

  def diff_saved_and_cost(age, event_sym)
    (culculated_amount(age) - result.cost_until_age(age) - result.each_stage_cost[event_sym]).to_s(:delimited)
  end
end
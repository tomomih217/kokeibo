require 'json'

class ResultDecorator < ApplicationDecorator
  delegate_all

  def format_total_cost
    total_cost.to_s(:delimited)
  end

  def format_cost_per_month
    cost_per_month = total_cost / duration
    cost_per_month.to_s(:delimited)
  end
end

require 'json'

class ResultDecorator < ApplicationDecorator
  delegate_all

  def format_total_cost
    total_cost.to_s(:delimited)
  end

  def format_cost_per_month
    cost_per_month.to_s(:delimited)
  end

  def format_amount(amount)
    amount.to_s(:delimited)
  end

  def translated_school_type(school_type)
    en = send(school_type)
    case en
    when 'public'then
      return '公立'
    when 'private' then
      return '私立'
    when 'publicArts' then
      return '公立文系'
    when 'publicScrience' then
      return '公立理系'
    when 'privateArts' then
      return '私立文系'
    when 'privateScience' then
      return '私立理系'
    else
      return en
    end
  end

  def formated_age(str)
    "#{str.gsub(/[^0-9]/,"")}才"
  end

end

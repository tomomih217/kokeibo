require 'json'

class ResultDecorator < ApplicationDecorator
  delegate_all

  def duration
    (18 - object.age) * 12
  end

  def total_cost
    cost_array = []

    # JSONからデータ取得
    cost_datas = {}
    File.open('./public/education_cost.json') do |file|
      cost_datas = JSON.load(file)
    end
    return 0 if cost_datas.empty?
    caluculateCost(cost_datas)
  end

  def caluculateCost(datas)
    total = 0
    schoolTypes = [
      'nurserySchool',
      'kindergarten',
      'primarySchool',
      'juniorHighSchool',
      'highSchool',
      'university'
    ]
    ageRange = {
      nursery_school: ["age1", "age2"],
      kindergarten: ["age3", "age4", "age5"],
      primary_school: ["age6", "age7", "age8", "age9", "age10", "age11"],
      junior_high_school: ["age12", "age13", "age14"],
      high_school: ["age15", "age16", "age17"],
      university: ["age18", "age19", "age20", "age21"]
    }

    schoolTypes.each do |schoolType|
      ageRange[schoolType.underscore.to_sym].each do |age|
        data = datas[schoolType][object.send(schoolType.underscore)][age]
        total += data
      end
    end

    total += object.living_alone_funds.zero? ? 0 : datas['livingAllowance']['initialize'] + object.living_alone_funds * 10000 * 12 * 4

    total
  end

  def format_total_cost
    total_cost.to_s(:delimited)
  end

  def format_cost_per_month
    cost_per_month = total_cost / duration
    cost_per_month.to_s(:delimited)
  end
end

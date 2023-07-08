class Result < ApplicationRecord
  belongs_to :child

  validates :age, presence: true
  validates :nursery_school, presence: true
  validates :kindergarten, presence: true
  validates :primary_school, presence: true
  validates :junior_high_school, presence: true
  validates :high_school, presence: true
  validates :university, presence: true
  validates :living_alone_funds, presence: true

  def self.params_format(result_params)
    age = result_params[:age]
    age == '出産前' ? result_params[:age] = 0 : result_params[:age] = age.to_i
    living_alone_funds = result_params[:living_alone_funds]
    living_alone_funds == '仕送りの予定はない' ? result_params[:living_alone_funds] = 0 : result_params[:living_alone_funds] = living_alone_funds.delete(',').to_i

    result_params
  end

  def self.json_cost_datas
    # JSONからデータ取得
    cost_datas = {}
    File.open('./public/education_cost.json') do |file|
      cost_datas = JSON.load(file)
    end
  end

  def duration
    (18 - age) * 12
  end

  def total_cost
    cost_datas_hash(json_datas).values.sum
  end

  def cost_datas_hash
    json_datas = Result.json_cost_datas
    cost_datas = {}
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
      school_type = schoolType.underscore.to_sym
      ageRange[school_type].each do |age|
        data = json_datas[schoolType][send(school_type)][age]
        cost_datas[school_type] = data
      end
    end

    cost_datas[:living_alone_funds] = living_alone_funds.zero? ? 0 : json_datas['livingAllowance']['initialize'] + living_alone_funds * 10000 * 12 * 4
    cost_datas
  end

end

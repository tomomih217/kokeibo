class Result < ApplicationRecord
  belongs_to :child

  validates :age, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :nursery_school, presence: true
  validates :kindergarten, presence: true
  validates :primary_school, presence: true
  validates :junior_high_school, presence: true
  validates :high_school, presence: true
  validates :university, presence: true
  validates :living_alone_funds, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def self.params_format(result_params)
    age = result_params[:age]
    if age == '選択してください'
      result_params[:age] = -1
    else
      age == '出産前' ? result_params[:age] = 0 : result_params[:age] = age.to_i
    end
    living_alone_funds = result_params[:living_alone_funds]
    if living_alone_funds == '選択してください'
      result_params[:living_alone_funds] = -1
    else
      living_alone_funds == '仕送りの予定はない' ? result_params[:living_alone_funds] = 0 : result_params[:living_alone_funds] = living_alone_funds.delete(',').to_i
    end

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
    cost_datas_hash.values.sum
  end

  def cost_per_month
    total_cost / duration
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
      total = 0
      school_type = schoolType.underscore.to_sym
      ageRange[school_type].each do |age|
        data = json_datas[schoolType][send(school_type)][age]
        total += data
      end
      cost_datas[school_type] = total
    end

    cost_datas[:living_alone_funds] = living_alone_funds.zero? ? 0 : json_datas['livingAllowance']['initialize'] + living_alone_funds * 10000 * 12 * 4
    cost_datas
  end

  def each_stage_cost
    result_hash = {}
    datas = Result.json_cost_datas
    cost_hash = cost_datas_hash

    high_school_cost = cost_hash[:nursery_school] + cost_hash[:kindergarten] + cost_hash[:primary_school] + cost_hash[:junior_high_school] + 350000
    result_hash[:high_school_cost] = high_school_cost
    
    university_entry_cost = { publicArts: 672000, publicScience: 672000, privateArts: 818000, privateScience: 888000 }
    university_cost = high_school_cost + cost_hash[:high_school] + university_entry_cost[university.to_sym]
    result_hash[:university_cost] = university_cost
    result_hash
  end
end

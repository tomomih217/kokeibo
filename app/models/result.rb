class Result < ApplicationRecord
  belongs_to :child
  BLANK = -1
  MAX_AGE = 18
  MONTHS_PER_YEAR = 12
  YEARS_FOR_UNI = 4
  TEN_THOUSAND = 10_000
  HIGH_SCHOOL_ENTRY_COST = 350_000

  validates :age, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :nursery_school, presence: true
  validates :from_age_for_nursery_school, numericality: { greater_than_or_equal_to: 0 }
  validates :kindergarten, presence: true
  validates :primary_school, presence: true
  validates :junior_high_school, presence: true
  validates :high_school, presence: true
  validates :university, presence: true
  validates :living_alone_funds, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def self.params_format(result_params)
    age = result_params[:age]
    result_params[:age] = if age == '選択してください'
                            BLANK
                          else
                            age == '出産前' ? 0 : age.to_i
                          end
    result_params[:from_age_for_nursery_school] = 0 if result_params[:nursery_school] == 'unselected'
    living_alone_funds = result_params[:living_alone_funds]
    result_params[:living_alone_funds] = if living_alone_funds == '選択してください'
                                           BLANK
                                         else
                                           living_alone_funds == '仕送りの予定はない' ? 0 : living_alone_funds.delete(',').to_i
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

  def self.school_types
    schoolTypes = %w[
      nursery_school
      kindergarten
      primary_school
      junior_high_school
      high_school
      university
    ]
    schoolTypes
  end

  def age_range
    ageRange = {
      nursery_school: %w[age1 age2],
      kindergarten: %w[age3 age4 age5],
      primary_school: %w[age6 age7 age8 age9 age10 age11],
      junior_high_school: %w[age12 age13 age14],
      high_school: %w[age15 age16 age17],
      university: %w[age18 age19 age20 age21]
    }
    if unselected?('kindergarten')
      array = []
      (from_age_for_nursery_school..5).each do |target_age|
        array.push("age#{target_age}")
      end
      ageRange[:nursery_school] = array
      ageRange[:kindergarten] = []
    end
    ageRange
  end

  def duration
    (MAX_AGE - age) * MONTHS_PER_YEAR
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
    
    ageRange = age_range

    schoolTypes.each do |schoolType|
      total = 0
      school_type = schoolType.underscore.to_sym
      unless unselected?(school_type)
        ageRange[school_type].each do |target_age|
          data = json_datas[schoolType][send(school_type)][target_age]
          total += data if target_age.gsub(/[^\d]/, "").to_i >= age
        end
      end
      cost_datas[school_type] = total
    end

    cost_datas[:living_alone_funds] =
      living_alone_funds.zero? ? 0 : json_datas['livingAllowance']['initialize'] + total_living_alone_funds
    cost_datas
  end

  def cost_datas_by_age
    json_datas = Result.json_cost_datas
    cost_datas = {}
    schoolTypes = %w[
      nurserySchool
      kindergarten
      primarySchool
      juniorHighSchool
      highSchool
      university
    ]
    ageRange = age_range

    schoolTypes.each do |schoolType|
      school_type = schoolType.underscore.to_sym
      unless unselected?(school_type)
        ageRange[school_type].each do |target_age|
          data = json_datas[schoolType][send(school_type)][target_age]
          target_age.gsub(/[^\d]/, "").to_i >= age ? cost_datas[target_age.to_sym] = data : cost_datas[target_age.to_sym] = 0
        end
      end
    end
    cost_datas[:living_alone_initialize] = living_alone_funds.zero? ? 0 : json_datas['livingAllowance']['initialize']
    cost_datas[:living_alone_funds] = total_living_alone_funds
    cost_datas
  end

  def each_stage_cost
    result_hash = {}

    # 高校入学費用
    result_hash[:high_school_cost] = HIGH_SCHOOL_ENTRY_COST

    # 大学入学費用
    university_entry_cost = { publicArts: 672_000, publicScience: 672_000, privateArts: 818_000, privateScience: 888_000 }
    unselected?('university') ? result_hash[:university_cost] = 0 : result_hash[:university_cost] = university_entry_cost[university.to_sym]
    result_hash
  end

  def total_living_alone_funds
    living_alone_funds * TEN_THOUSAND * MONTHS_PER_YEAR * YEARS_FOR_UNI
  end

  def unselected?(school_type)
    return send(school_type) == 'unselected'
  end

  def cost_until_age(target_age)
    datas = cost_datas_by_age.to_a
    total = 0
    datas.each do |data|
      if data[0].to_s.gsub(/[^\d]/, "").to_i <= target_age
        total += data[1] if data[0].to_s.gsub(/[^\d]/, "").to_i >= age
      end
    end
    total
  end

  def cost_array_for_graph
    array = [0]
    (1..18).each do |idx|
      if idx % 3 == 0
        array.push(cost_until_age(idx))
      end
    end
    array.push(cost_until_age(22))
  end
end

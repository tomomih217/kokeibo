class PlanForm
  include ActiveModel::Model
  include ActiveModel::Callbacks
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks

  FORM_COUNT = 3
  attr_accessor :plans

  # 初期化
  # fields_forを使用するため、Planインスタンスを規定の個数生成する
  def initialize(attributes = {})
    super attributes
    self.plans ||= FORM_COUNT.times.map { Plan.new }
  end

  # 取得したパラメータを各Planインスタンスに格納
  def plans_attributes=(attributes)
    self.plans = attributes.map { |_, v| Plan.new(v) }
  end

  # planインスタンスの一括保存
  def save
    Plan.transaction do
      index = 0
      plans.map do |plan|
        plan.save! unless index != 0 && plan.attribute_empty?
        index += 1
      end
    end
    true
  rescue StandardError
    false
  end
end

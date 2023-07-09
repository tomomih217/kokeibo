class SaveScheduleForm
  include ActiveModel::Model
  include ActiveModel::Callbacks
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks

  FORM_COUNT = 3
  attr_accessor :results

  def initialize(attributes = {})
    super attributes
    self.results = FORM_COUNT.times.map { Result.new() } unless self.results.present?
  end

  def results_attributes=(attributes)
    self.results = attributes.map { |_, v| Result.new(v) }
  end

  def save_schedule
    Result.transaction do
      self.results.map do |result|
        result.save
      end
    end
      return true
    rescue => e
      return false
  end
end
class SaveScheduleForm
  include ActiveModel::Model
  include ActiveModel::Callbacks
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks

  FORM_COUNT = 3
  attr_accessor :save_schedules

  def initialize(attributes = {})
    super attributes
    self.save_schedules = FORM_COUNT.times.map { SaveSchedule.new() } unless self.save_schedules.present?
  end

  def save_schedules_attributes=(attributes)
    self.save_schedules = attributes.map { |_, v| SaveSchedule.new(v) }
  end

  def save(user)
    child = user.children[0]
    SaveSchedule.transaction do
      self.save_schedules.map do |save_schedule|
        save_schedule.child = child
        binding.pry
        save_schedule.save
      end
    end
      return true
    rescue => e
      return false
  end
end
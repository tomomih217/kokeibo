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
      i = 0
      self.save_schedules.map do |save_schedule|
        unless empty?(save_schedule) && i != 0
          save_schedule.child = child
          save_schedule.save!
        end
        i += 1
      end
    end
      return true
    rescue => e
      return false
  end

  def empty?(save_schedule)
    save_schedule.age_from.blank? && save_schedule.age_to.blank? && save_schedule.amount.blank?
  end
end

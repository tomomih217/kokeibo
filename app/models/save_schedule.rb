class SaveSchedule < ApplicationRecord
  belongs_to :child

  validates :age_from, presence: true
  validates :age_to, presence: true
  validates :amount, presence: true
end

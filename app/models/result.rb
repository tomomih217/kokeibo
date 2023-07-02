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
end

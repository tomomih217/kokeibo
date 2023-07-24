class Child < ApplicationRecord
  belongs_to :user
  has_many :plans, dependent: :destroy
  has_one :result
  has_many :payment_collections, dependent: :destroy
  has_many :payments, through: :payment_collections

  validates :name, presence: true, length: { maximum: 255 }
  validates :stage, presence: true

  enum stage: {
    expect_baby: 0,
    age_0: 1,
    age_1: 2,
    age_2: 3,
    kindergarten_1: 4,
    kindergarten_2: 5,
    kindergarten_3: 6,
    primary_1: 7,
    primary_2: 8,
    primary_3: 9,
    primary_4: 10,
    primary_5: 11,
    primary_6: 12,
    jrHigh_1: 13,
    jrHigh_2: 14,
    jrHigh_3: 15,
    high_1: 16,
    high_2: 17,
    high_3: 18
  }

  def age
    Child.stages[stage]
  end

  def start_day
    payment_collections.order(paymented_at: :asc).pluck(:paymented_at)[0]
  end

  def estimated_amount
    amount_per_month = plans.sum(:amount)
    t = Date.today.year * 12 + Date.today.month
    s = start_day.year * 12 + start_day.month
    duration = t - s
    amount_per_month * duration
  end

  def diff_amount
    payments.sum(:amount) - estimated_amount
  end

  def duration(age)
    t = Date.today.year * 12 + Date.today.month
    culculated_date = (Date.today + age.years)
    s_day = Date.new(culculated_date.year, 3, 31)
    s = culculated_date.year * 12 + 3
    s - t
  end

  def culculated_amount(age)
    plans.sum(:amount) * duration(age)
  end
end

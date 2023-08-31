class Child < ApplicationRecord
  belongs_to :user
  has_many :plans, dependent: :destroy
  has_one :result
  has_many :payment_collections, dependent: :destroy
  has_many :payments, through: :payment_collections
  has_many :stamps, dependent: :destroy

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
    duration = t - s + 1
    amount_per_month * duration
  end

  def diff_amount
    payments.sum(:amount) - estimated_amount
  end

  def duration(age)
    (age - result.age) * 12
  end

  def culculated_amount(age)
    plans.sum(:amount) * duration(age)
  end

  def stamping(day)
    plans_array = plans.pluck(:item)
    day ||= Date.today
    count = plans_array.size
    collections = payment_collections.where(paymented_at: day.beginning_of_month..day.end_of_month)
    collections.each do |collection|
      collection.payments.each do |payment|
        if plans_array.include?(payment.item)
          plans_array.delete(payment.item)
        end
      end
    end

    # stampステータスの判定
    if plans_array.size == count
      attributes = {
        stamped_at: day.beginning_of_month,
        status: :unpayed
      }
    elsif plans_array.size == 0
      attributes = {
        stamped_at: day.beginning_of_month,
        status: :complete
      }
    else
      attributes = {
        stamped_at: day.beginning_of_month,
        status: :payed
      }
    end
    stamp(attributes)
  end

  def stamp(attributes)
    existing_stamp = stamps.find_by(stamped_at: attributes[:stamped_at])

    if existing_stamp
      if existing_stamp.status != attributes[:status]
        existing_stamp.update(attributes)
      end
      existing_stamp
    else
      stamps.create(attributes)
    end
  end
end

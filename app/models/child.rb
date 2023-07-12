class Child < ApplicationRecord
  belongs_to :user
  has_many :plans
  has_one :result

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
end

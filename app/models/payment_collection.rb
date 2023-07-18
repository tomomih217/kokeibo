class PaymentCollection < ApplicationRecord
  belongs_to :child
  has_many :payments
  accepts_nested_attributes_for :payments

  validates :paymented_at, presence: true
end

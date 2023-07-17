class PaymentCollection < ApplicationRecord
  belongs_to :child
  has_many :payments, dependent: :destroy

  validates :paymented_at, presence: true
end

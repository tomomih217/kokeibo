class Payment < ApplicationRecord
  belongs_to :payment_collection

  validates :item, presence: true, length: { maximum: 255 }
  validates :amount, presence: true
end

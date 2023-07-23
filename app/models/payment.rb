class Payment < ApplicationRecord
  belongs_to :payment_collection
  has_one :master, through: :payment_collection

  validates :item, presence: true, length: { maximum: 255 }
  validates :amount, presence: true
end

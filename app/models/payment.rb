class Payment < ApplicationRecord
  belongs_to :child

  validates :item, presence: true, length: { maximum: 255 }
  validates :amount, presence: true
end

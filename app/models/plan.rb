class Plan < ApplicationRecord
  belongs_to :child

  validates :item, presence: true, length: { maximum: 255 }
  validates :amount, presence: true
  validates :payment_day, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 31 }

  def attribute_empty?
    item.blank? && amount.blank? && payment_day.blank?
  end
end

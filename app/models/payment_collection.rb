class PaymentCollection < ApplicationRecord
  belongs_to :child
  has_many :payments, dependent: :destroy
  accepts_nested_attributes_for :payments, reject_if: :all_blank, allow_destroy: true

  validates :paymented_at, presence: true

  scope :by_recently_paymented_at, -> { order(paymented_at: :desc) }

  def get_payments_with_plans(child)
    self.payments = Array.new(3){ Payment.new }
    plans = child.plans
    plans.each_with_index do |plan, idx|
      payments[idx].item = plan.item
      payments[idx].amount = plan.amount
    end
  end
end

class PlanCollection < ApplicationRecord
  has_many :plans
  accepts_nested_attributes_for :plans, allow_destroy: true, reject_if: :all_blank, limit: 3
end
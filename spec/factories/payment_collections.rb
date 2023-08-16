FactoryBot.define do
  factory :payment_collection do
    paymented_at { Date.today }
    is_auto { false }

    child

    trait :is_auto do
      is_auto { true }
    end
  end
end

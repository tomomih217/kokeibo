FactoryBot.define do
  factory :plan do
    sequence(:item, 'item_01')
    amount { 10_000 }
    payment_day { 20 }
    is_auto { false }

    child

    trait :is_auto do
      payment_day { 1 }
      is_auto { true }
    end
  end
end

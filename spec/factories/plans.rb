FactoryBot.define do
  factory :plan do
    sequence(:item, 'item_01')
    amount { 10_000 }
    payment_day { 20 }
    is_auto { true }

    child

    trait :is_no_auto do
      is_auto { false }
    end
  end
end

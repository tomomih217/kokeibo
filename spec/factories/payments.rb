FactoryBot.define do
  factory :payment do
    item { '保険' }
    amount { 10000 }

    payment_collection

    trait :insurance do
      item { '学資保険' }
      amount { 12000 }
    end

    trait :investment do
      item { 'つみたてNISA' }
      amount { 20000 }
    end

    trait :savings do
      item { '口座' }
      amount { 30000 }
    end
  end
end
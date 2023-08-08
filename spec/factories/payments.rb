FactoryBot.define do
  factory :payment do
    item { '保険' }
    amount { 10_000 }

    payment_collection

    trait :insurance do
      item { '学資保険' }
      amount { 12_000 }
    end

    trait :investment do
      item { 'つみたてNISA' }
      amount { 20_000 }
    end

    trait :savings do
      item { '口座' }
      amount { 30_000 }
    end
  end
end

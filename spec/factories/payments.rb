FactoryBot.define do
  factory :payment do
    item { '保険' }
    amount { 10000 }

    payment_collection
  end
end
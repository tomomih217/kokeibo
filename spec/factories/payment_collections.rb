FactoryBot.define do
  factory :payment_collection do
    paymented_at { Date.today }
    
    child
  end
end
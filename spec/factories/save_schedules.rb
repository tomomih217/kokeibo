FactoryBot.define do
  factory :save_schedule do
    age_from { 0 }
    age_to { 18 }
    amount { '100,000' }

    child
  end
end

FactoryBot.define do
  factory :stamp do
    status { 0 }
    stamped_at { Date.today }

    child

    trait :payed do
      status { 1 }
    end

    trait :complete do
      status { 2 }
    end
  end
end
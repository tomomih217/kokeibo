FactoryBot.define do
  factory :result do
    age { 0 }
    nursery_school { 'private' }
    kindergarten { 'private' }
    primary_school { 'public' }
    junior_high_school { 'public' }
    high_school { 'private' }
    university { 'privateScience' }
    living_alone_funds { '3' }

    child
  end
end

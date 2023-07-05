FactoryBot.define do
  factory :result do
    age { 1 }
    nursery_school { 'private' }
    kindergarten { 'private' }
    primary_school { 'public' }
    junior_high_school { 'public' }
    high_school { 'private' }
    university { 'privateScience' }
    living_alone_funds { '30' }

    child
  end
end
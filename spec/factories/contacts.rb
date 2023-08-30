FactoryBot.define do
  factory :contact do
    email { info@example.com }
    content { 'これはお問い合わせのテストです' }
    
    user
  end
end
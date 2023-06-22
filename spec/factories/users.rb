FactoryBot.define do
  factory :user do
    name { 'Test_1' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end

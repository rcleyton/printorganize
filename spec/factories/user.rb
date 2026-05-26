FactoryBot.define do
  factory :user do
    email_address { Faker::Internet.unique.email }
    password { 'P@ssword01' }
    password_confirmation { 'P@ssword01' }
  end
end

FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    category { "Any" }
    material_weight { rand(50..2000).to_f }
    production_time_seconds { rand(30..1440).to_i }
    status { :active }
  end
end

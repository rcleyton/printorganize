FactoryBot.define do
  factory :filament do
    name           { Faker::Commerce.product_name }
    brand          { "eSUN" }
    material_type  { :pla }
    color          { Faker::Color.color_name }
    initial_weight { 1000.0 }
    purchase_price { 89.90 }
  end
end

require 'rails_helper'

RSpec.describe Filament, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    subject { build(:filament) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:brand) }
    it { should validate_presence_of(:material_type) }
    it { should validate_presence_of(:color) }

    it { should validate_presence_of(:initial_weight) }
    it { should validate_numericality_of(:initial_weight).is_greater_than(0) }

    it { should validate_presence_of(:purchase_price) }
    it { should validate_numericality_of(:purchase_price).is_greater_than(0) }

    it { should define_enum_for(:material_type).with_values(pla: 0, petg: 1, abs: 2, tpu: 3) }
  end

  describe 'callbacks' do
    it 'calculates price_per_gram before saving' do
      filament = build(:filament, initial_weight: 1000, purchase_price: 100, user: create(:user))
      filament.save!

      expect(filament.price_per_gram).to eq(0.1)
    end
  end
end

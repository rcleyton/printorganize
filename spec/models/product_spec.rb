require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    subject { build(:product) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:category) }
    it { should validate_presence_of(:material_weight) }
    it { should validate_presence_of(:production_time_seconds) }
    it { should validate_numericality_of(:production_time_seconds).is_greater_than(0) }
    it { should validate_numericality_of(:material_weight).is_greater_than(0) }
    it { should define_enum_for(:status).with_values(active: 0, inactive: 1) }
  end
end

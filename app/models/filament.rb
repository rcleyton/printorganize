class Filament < ApplicationRecord
  belongs_to :user
  validates :user, presence: true

  enum :material_type, { pla: 0, petg: 1, abs: 2, tpu: 3 }

  before_save :calculate_price_per_gram

  validates :name,          presence: true
  validates :brand,         presence: true
  validates :material_type, presence: true
  validates :color,         presence: true
  validates :initial_weight,
            presence: true,
            numericality: { greater_than: 0 }
  validates :purchase_price,
            presence: true,
            numericality: { greater_than: 0 }

  private

  def calculate_price_per_gram
    return if purchase_price.blank? || initial_weight.blank? || initial_weight <= 0

    self.price_per_gram = purchase_price.to_d / initial_weight.to_d
  end
end

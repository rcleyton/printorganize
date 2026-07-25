class Product < ApplicationRecord
  belongs_to :user

  validates :name, :user, presence: true
  validates :description, :category, :material_weight, :production_time_seconds, :status, presence: true
  validates :material_weight, numericality: { greater_than: 0 }
  validates :production_time_seconds, numericality: { greater_than: 0 }


  enum :status, { active: 0, inactive: 1 }
end

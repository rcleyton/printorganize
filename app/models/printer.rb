class Printer < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :serial, presence: true
end

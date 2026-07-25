class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :filaments, dependent: :destroy
  has_many :printers, dependent: :destroy
  has_many :products, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :email_address, presence: true, uniqueness: { case_sensitive: false }, email: true
  validates :password, length: { minimum: 8 }, password: true, if: :password_required?

  private

  def password_required?
    new_record? || password.present? || password_confirmation.present?
  end
end

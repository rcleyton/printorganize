require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    subject(:user) { build(:user) }

    it { should validate_presence_of(:email_address) }

    it { should validate_uniqueness_of(:email_address).case_insensitive }
  end

  describe "email normalization" do
    it "normalizes email before validation" do
      user = create(:user, email_address: "NEWUSER@Example.COM")

      expect(user.email_address).to eq("newuser@example.com")
    end
  end

  describe "email format" do
    it "must be valid" do
      user = build(:user, email_address: "foo@bar")

      expect(user).not_to be_valid
      expect(user.errors[:email_address]).to include(I18n.t("errors.messages.invalid_format"))
    end
  end

  describe "password validations" do
    it { should validate_length_of(:password).is_at_least(8) }
  
    it "does not allow spaces" do
      user = build(
        :user,
        password: "Password 1",
        password_confirmation: "Password 1"
      )

      expect(user).not_to be_valid
      expect(user.errors[:password]).to include(I18n.t("errors.messages.password_contains_whitespace"))
    end

    it "confirmation must match password" do
      user = build(
        :user,
        password: "Diferent!",
        password_confirmation: "Different1!"
      )

      expect(user).not_to be_valid
      expect(user.errors[:password_confirmation]).to include("as senhas não são iguais")
    end

    it "password must contain letters, numbers, and special characters" do
      user = build(
        :user,
        password: "Password1",
        password_confirmation: "Password1"
      )
      
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include(I18n.t("errors.messages.password_not_complex"))
    end
  end
end

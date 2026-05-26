require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /signup" do
    it "return success" do
      get signup_path

      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /signup" do
    context "with valid params" do
      let(:params) do
        {
          user: { 
            email_address: "user@example.com",
            password: "P@ssword01",
            password_confirmation: "P@ssword01"
          }
        }
      end

      it "create user" do
        expect { 
          post signup_path, params: params
        }.to change(User, :count).by(1)
      end

      it "redirect after  signup" do
        post signup_path, params: params

        expect(response).to redirect_to(new_session_path)
      end
    end
  end
end

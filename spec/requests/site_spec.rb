require 'rails_helper'

RSpec.describe "Site", type: :request do
  describe "GET /root" do
    it "return success" do
      get root_path 

      expect(response).to have_http_status(:ok)
    end
  end 
end

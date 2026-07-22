require 'rails_helper'

RSpec.describe "Dashboard::Filaments", type: :request do
  let(:user) { create(:user) }

  before do
    post session_path, params: { email_address: user.email_address, password: user.password }
  end

  describe "GET /dashboard/filaments" do
    it "returns http success" do
      get dashboard_filaments_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /dashboard/filaments/:id" do
    let(:user) { create(:user) }
    let(:filament) { create(:filament, user: user) }

    it "returns http success" do
      get dashboard_filament_path(filament)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /dashboard/filaments/new" do
    it "returns http success" do
      get new_dashboard_filament_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /dashboard/filaments" do
    context "with valid parameters" do
      let(:valid_params) do
        {
          filament: {
            name: "PLA Premium",
            brand: "eSUN",
            material_type: "pla",
            color: "Preto",
            initial_weight: 1000,
            purchase_price: 99.90
          }
        }
      end

      it "creates a new Filament" do
        expect {
          post dashboard_filaments_path, params: valid_params
        }.to change(Filament, :count).by(1)
      end

      it "calculates price_per_gram" do
        post dashboard_filaments_path, params: valid_params
        filament = Filament.last
        expect(filament.price_per_gram).to eq(0.0999)
      end

      it "redirects to filaments index" do
        post dashboard_filaments_path, params: valid_params
        expect(response).to redirect_to(dashboard_filaments_path)
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) do
        {
          filament: {
            name: "",
            material_type: "pla",
            color: "Preto",
            initial_weight: 0,
            purchase_price: -10
          }
        }
      end

      it "does not create a new Filament" do
        expect {
          post dashboard_filaments_path, params: invalid_params
        }.not_to change(Filament, :count)
      end

      it "returns unprocessable entity status" do
        post dashboard_filaments_path, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /dashboard/filaments/:id/edit" do
    let(:user) { create(:user) }
    let(:filament) { create(:filament, user: user) }

    it "returns http success" do
      get edit_dashboard_filament_path(filament)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH /dashboard/filaments/:id" do
    let(:user) { create(:user) }
    let(:filament) { create(:filament, user: user) }

    context "with valid parameters" do
      let(:new_attributes) do
        {
          filament: {
            name: "PLA Updated Name",
            brand: "Bambu Lab",
            color: "Azul"
          }
        }
      end

      it "updates the requested filament" do
        patch dashboard_filament_path(filament), params: new_attributes
        filament.reload
        expect(filament.name).to eq("PLA Updated Name")
        expect(filament.brand).to eq("Bambu Lab")
        expect(filament.color).to eq("Azul")
      end

      it "redirects to the filaments list" do
        patch dashboard_filament_path(filament), params: new_attributes
        expect(response).to redirect_to(dashboard_filaments_path)
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) do
        {
          filament: {
            name: ""
          }
        }
      end

      it "returns unprocessable entity status" do
        patch dashboard_filament_path(filament), params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /dashboard/filaments/:id" do
    let!(:user) { create(:user) }
    let!(:filament) { create(:filament, user: user) }

    it "destroys the requested filament" do
      expect {
        delete dashboard_filament_path(filament)
      }.to change(Filament, :count).by(-1)
    end

    it "redirects to the filaments list" do
      delete dashboard_filament_path(filament)
      expect(response).to redirect_to(dashboard_filaments_path)
    end
  end
end

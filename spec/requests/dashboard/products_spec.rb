require 'rails_helper'

RSpec.describe "Dashboard::Products", type: :request do
  let(:user) { create(:user) }

  before do
    post session_path, params: { email_address: user.email_address, password: user.password }
  end

  describe "GET /dashboard/products" do
    it "returns http success" do
      get dashboard_products_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /dashboard/products/:id" do
    let(:product) { create(:product, user: user) }

    it "returns http success" do
      get dashboard_product_path(product)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /dashboard/products/new" do
    it "returns http success" do
      get new_dashboard_product_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /dashboard/products" do
    context "with valid parameters" do
      let(:valid_params) do
        {
          product: {
            name: "Carregador de celular",
            description: "Carregador de celular de mesa",
            category: "Organizadores de mesa",
            material_weight: 26.0,
            production_time_seconds: 3600,
            status: "active"
          }
        }
      end

      it "creates a new Product" do
        expect {
          post dashboard_products_path, params: valid_params
        }.to change(Product, :count).by(1)
      end

      it "redirects to the products index" do
        post dashboard_products_path, params: valid_params
        expect(response).to redirect_to(dashboard_products_path)
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) do
        {
          product: {
            name: "Carregador de celular",
            description: "Carregador de celular de mesa",
            material_weight: 26.0
          }
        }
      end

      it "does not create a new Product" do
        expect {
          post dashboard_products_path, params: invalid_params
        }.not_to change(Product, :count)
      end

      it "returns unprocessable entity status" do
        post dashboard_products_path, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /dashboard/products/:id/edit" do
    let(:user) { create(:user) }
    let(:product) { create(:product, user: user) }

    it "returns http success" do
      get edit_dashboard_product_path(product)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH /dashboard/products/:id" do
    let(:user) { create(:user) }
    let(:product) { create(:product, user: user) }

    context "with valid parameters" do
      let(:new_attributes) do
        {
          product: {
            name: "Product Updated",
            description: "Description Updated",
            material_weight: 20.0
          }
        }
      end

      it "updates the requested product" do
        patch dashboard_product_path(product), params: new_attributes
        product.reload
        expect(product.name).to eq("Product Updated")
        expect(product.description).to eq("Description Updated")
        expect(product.material_weight).to eq(20.0)
      end

      it "redirects to the products index" do
        patch dashboard_product_path(product), params: new_attributes
        expect(response).to redirect_to(dashboard_products_path)
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) do
        {
          product: {
            name: ""
          }
        }
      end

      it "returns unprocessable entity status" do
        patch dashboard_product_path(product), params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /dashboard/products/:id" do
    let!(:user) { create(:user) }
    let!(:product) { create(:product, user: user) }

    it "destroys the requested product" do
      expect {
        delete dashboard_product_path(product)
      }.to change(Product, :count).by(-1)
    end

    it "redirects to the products index" do
      delete dashboard_product_path(product)
      expect(response).to redirect_to(dashboard_products_path)
    end
  end
end

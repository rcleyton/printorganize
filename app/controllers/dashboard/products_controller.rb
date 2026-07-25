class Dashboard::ProductsController < DashboardController
  before_action :set_product, only: [ :show, :edit, :update, :destroy ]

  def index
    @products = current_user.products
  end

  def show; end

  def edit; end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user

    if @product.save
      flash[:success] = "Produto criado com sucesso"
      redirect_to dashboard_products_path
    else
      flash[:error] = "Verifique os campos em vermelho"
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      flash[:success] = "Produto atualizado com sucesso"
      redirect_to dashboard_products_path
    else
      flash[:error] = "Verifique os campos em vermelho"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    flash[:success] = "Produto excluído com sucesso"
    redirect_to dashboard_products_path
  end

  private

  def set_product
    @product = current_user.products.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :category, :material_weight, :production_time_seconds, :status)
  end
end

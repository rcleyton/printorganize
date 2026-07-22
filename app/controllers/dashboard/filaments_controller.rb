class Dashboard::FilamentsController < DashboardController
  before_action :set_filament, only: [ :show, :edit, :update, :destroy ]

  def index
    @filaments = current_user.filaments
  end

  def show; end

  def new
    @filament = Filament.new
  end

  def create
    @filament = current_user.filaments.new(filament_params)
    if @filament.save
      redirect_to dashboard_filaments_path, notice: "Filamento cadastrado com sucesso"
    else
      flash[:error] = "Verifique os campos em vermelho!"
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @filament.update(filament_params)
      redirect_to dashboard_filaments_path, notice: "Filamento atualizado com sucesso"
    else
      flash[:error] = "Verifique os campos em vermelho!"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @filament.destroy
    redirect_to dashboard_filaments_path, notice: "Filamento excluído com sucesso"
  end

  private

  def filament_params
    params.require(:filament).permit(
      :name,
      :brand,
      :material_type,
      :color,
      :initial_weight,
      :purchase_price
    )
  end

  def set_filament
    @filament = current_user.filaments.find(params[:id])
  end
end

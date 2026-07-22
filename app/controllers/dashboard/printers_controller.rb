class Dashboard::PrintersController < DashboardController
  before_action :set_printer, only: %i[ show edit update destroy ]

  def index
    @printers = current_user.printers
  end

  def show; end

  def new
    @printer = Printer.new
  end

  def create
    @printer = Printer.new(printer_params)
    @printer.user = current_user
    if @printer.save
      redirect_to dashboard_printers_path, notice: "Impressora criada com sucesso"
    else
      flash[:error] = "Verifique os campos em vermelho!"
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @printer.update(printer_params)
      redirect_to dashboard_printers_path, notice: "Impressora atualizada"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @printer.destroy
    redirect_to dashboard_printers_path, notice: "Impressora excluída"
  end

  private

  def printer_params
    params.require(:printer).permit(
      :printer_brand,
      :printer_model,
      :printer_name,
      :kilowatt_hour,
      :printer_ip,
      :serial,
      :access_code
    )
  end

  def set_printer
    @printer = current_user.printers.find(params[:id])
  end
end

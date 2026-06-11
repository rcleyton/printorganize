class Dashboard::HomeController < DashboardController
  def index
    @printers = Printer.all
  end
end

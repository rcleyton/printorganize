class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  rescue_from ActiveRecord::RecordNotFound, with: :redirect_unauthorized_resource

  private

  def redirect_unauthorized_resource
    redirect_to dashboard_home_path, alert: "Resource not found or unauthorized."
  end
end

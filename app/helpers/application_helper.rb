# app/helpers/application_helper.rb
module ApplicationHelper
  # Mapeia o tipo de flash do Rails para as variações aceitas pelo Toast
  def toast_variant_for(type)
    case type.to_sym
    when :notice, :info then :info
    when :alert, :warning then :warning
    when :error, :danger then :error
    when :success then :success
    else :default
    end
  end

  # Estilo de cor focado EXCLUSIVAMENTE no ícone (assim como no React)
  def toast_icon_style_for(type)
    variant = toast_variant_for(type)

    {
      success: "text-primary",
      error:   "text-destructive",
      warning: "text-amber-400 dark:text-amber-300",
      info:    "text-sky-500 dark:text-sky-400"
    }[variant]
  end

  # Ícone do Material Symbols equivalente ao Lucide do React
  def toast_icon_name_for(type)
    variant = toast_variant_for(type)

    {
      success: "check_circle",
      error:   "cancel",
      warning: "warning",
      info:    "info"
    }[variant]
  end
end

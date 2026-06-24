# frozen_string_literal: true

class InputComponent < ViewComponent::Base
  BASE_CLASSES = "h-8 w-full min-w-0 rounded-lg border border-input bg-transparent px-2.5 py-1 text-base transition-colors outline-none file:inline-flex file:h-6 file:border-0 file:bg-transparent file:text-sm file:font-medium file:text-foreground placeholder:text-muted-foreground focus-visible:border-ring focus-visible:ring-3 focus-visible:ring-ring/50 disabled:pointer-events-none disabled:cursor-not-allowed disabled:bg-input/50 disabled:opacity-50 aria-invalid:border-destructive aria-invalid:ring-3 aria-invalid:ring-destructive/20 md:text-sm dark:bg-input/30 dark:disabled:bg-input/80 dark:aria-invalid:border-destructive/50 dark:aria-invalid:ring-destructive/40"

  def initialize(form: nil, attribute: nil, type: :text, toggleable: false, **options)
    @form       = form
    @attribute  = attribute
    @type       = type.to_sym
    @toggleable = toggleable
    @options    = options
  end

  def html_options
    options = @options.dup
    options[:data] ||= {}
    options[:data][:slot] = "input"
    options[:type]        = @type

    if password_toggle?
      options[:data][:password_visibility_target] = "input"
    end

    if has_errors?
      options[:aria] ||= {}
      options[:aria][:invalid] = true
    end

    custom_classes  = options.delete(:class)
    options[:class] = [ BASE_CLASSES, custom_classes ].compact.join(" ")

    options
  end

  def form_helper_method
    case @type
    when :text     then :text_field
    when :email    then :email_field
    when :password then :password_field
    when :number   then :number_field
    when :search   then :search_field
    when :tel      then :telephone_field
    when :url      then :url_field
    else :text_field
    end
  end

  private

  def has_errors?
    return false unless @form&.object && @attribute
    @form.object.errors[@attribute].any?
  end

  def error_message
    @form.object.errors[@attribute].first if has_errors?
  end

  def password_toggle?
    @type == :password && @toggleable
  end
end

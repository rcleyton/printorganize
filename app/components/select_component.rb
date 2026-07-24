# frozen_string_literal: true

class SelectComponent < ViewComponent::Base
  BASE_CLASSES = "h-8 w-full min-w-0 rounded-lg border border-input bg-transparent px-2.5 py-1 text-base transition-colors outline-none focus-visible:border-ring focus-visible:ring-3 focus-visible:ring-ring/50 disabled:pointer-events-none disabled:cursor-not-allowed disabled:bg-input/50 disabled:opacity-50 aria-invalid:border-destructive aria-invalid:ring-3 aria-invalid:ring-destructive/20 md:text-sm dark:bg-input/30 dark:disabled:bg-input/80 dark:aria-invalid:border-destructive/50 dark:aria-invalid:ring-destructive/40"

  def initialize(form: nil, attribute: nil, collection: [], include_blank: nil, **options)
    @form          = form
    @attribute     = attribute
    @collection    = collection
    @include_blank = include_blank
    @options       = options
  end

  def html_options
    options = @options.dup

    if has_errors?
      options[:aria] ||= {}
      options[:aria][:invalid] = true
    end

    custom_classes  = options.delete(:class)
    options[:class] = [ BASE_CLASSES, custom_classes ].compact.join(" ")

    options
  end

  def select_options
    opts = {}
    opts[:include_blank] = @include_blank if @include_blank
    opts
  end

  private

  def has_errors?
    return false unless @form&.object && @attribute
    @form.object.errors[@attribute].any?
  end

  def error_message
    @form.object.errors[@attribute].first if has_errors?
  end
end

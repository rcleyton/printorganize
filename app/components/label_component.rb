# frozen_string_literal: true

class LabelComponent < ViewComponent::Base
  BASE_CLASSES = "flex items-center gap-2 text-sm leading-none font-medium select-none group-data-[disabled=true]:pointer-events-none group-data-[disabled=true]:opacity-50 peer-disabled:cursor-not-allowed peer-disabled:opacity-50"

  def initialize(form: nil, attribute: nil, **options)
    @form       = form
    @attribute  = attribute
    @options    = options
  end

  def html_options
    options = @options.dup

    options[:data] ||= {}
    options[:data][:slot] = "label"

    custom_classes  = options.delete(:class)
    options[:class] = [ BASE_CLASSES, custom_classes ].compact.join(" ")

    options
  end
end

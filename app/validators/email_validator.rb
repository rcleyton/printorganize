class EmailValidator < ActiveModel::EachValidator
  EXPRESSION = /\A[a-zA-Z0-9_.-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z]{2,})+\z/

  def validate_each(record, attribute, value) 
    return if value.blank? || value.match?(EXPRESSION)

    record.errors.add(attribute, message)
  end

  private

  def message
    options[:message].presence || I18n.t("errors.messages.invalid_format")
  end
end

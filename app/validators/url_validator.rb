class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    valid = begin
      URI.parse(value).kind_of?(URI::HTTP)
    rescue URI::InvalidURIError
      false
    end

    record.errors[attribute] << (options[:message] || "is an invalid URL") unless valid
  end
end

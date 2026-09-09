class PhoneNumber
  SAUDI_MOBILE_REGEX = /\A\+9665\d{8}\z/

  def self.normalize(phone_number)
    value = phone_number.to_s.strip.gsub(/[\s-]/, "")

    if value.start_with?("05") && value.length == 10
      "+966#{value[1..]}"
    elsif value.start_with?("9665") && value.length == 12
      "+#{value}"
    else
      value
    end
  end

  def self.valid?(phone_number)
    normalized = normalize(phone_number)

    normalized.match?(SAUDI_MOBILE_REGEX)
  end
end

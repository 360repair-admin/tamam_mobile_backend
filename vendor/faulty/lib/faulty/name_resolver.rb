module Faulty
  class NameResolver
    FIELD_PRIORITY = %w[
      full_name
      name
      display_name
      username
      email
    ].freeze

    def self.call(record)
      return "Unknown" if record.nil?

      # Prefer English names if present
      if record.respond_to?(:first_name_en) || record.respond_to?(:last_name_en)
        name = [safe_value(record, :first_name_en), safe_value(record, :last_name_en)].compact_blank.join(" ")
        return name if name.present?
      end

      # Fallback to non-localized names
      if record.respond_to?(:first_name) || record.respond_to?(:last_name)
        name = [safe_value(record, :first_name), safe_value(record, :last_name)].compact_blank.join(" ")
        return name if name.present?
      end

      # Try single-field names
      FIELD_PRIORITY.each do |field|
        next unless record.respond_to?(field)
        value = safe_value(record, field)
        return value if value.present?
      end

      # Fallbacks
      return "User ##{record.id}" if record.respond_to?(:id)
      "Unknown"
    end

    def self.safe_value(record, field)
      record.public_send(field).presence rescue nil
    end
  end
end

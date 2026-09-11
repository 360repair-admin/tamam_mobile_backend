module Faulty
  class << self
    attr_accessor :enabled_environments, :current_faulty_user, :enabled_authorization, :authorized_users

    def configure
      yield self
    end

    def capture(exception, context: {}, request_id: nil)
      return unless should_capture?

      fingerprint = generate_fingerprint(exception)

      error = ::Faulty::Error.find_by(fingerprint: fingerprint)

      if error.present?
        error.update!(last_event_at: Time.current)
      else
        error = ::Faulty::Error.create!(
          fingerprint: fingerprint,
          error_class: exception.class.name,
          message: exception.message,
          last_event_at: Time.current
        )
      end

      ::Faulty::Event.create!(
        error: error,
        backtrace: exception.backtrace&.join("\n"),
        context:   context,
        code_snippet: capture_code_snippets(exception.backtrace),
        request_id: request_id
      )
    end

    def resolved_authorized_users
      val = authorized_users 
      val = val.call if val.respond_to?(:call)
      val || []
    end

    private

    def should_capture?
      return true unless defined?(Rails)
      enabled_environments&.include?(Rails.env)
    end

    def generate_fingerprint(exception)
      first_lines = exception.backtrace&.first(5) || []
      Digest::SHA256.hexdigest([exception.class.name, first_lines.join("\n")].join(":"))
    end

    def capture_code_snippets(backtrace, max_frames: 5)
      return nil if backtrace.blank?

      lines = backtrace.is_a?(String) ? backtrace.split("\n") : backtrace

      # pick frames inside your app
      app_frames = lines.select { |line| line.include?(Rails.root.join("app").to_s) }

      snippets = []

      app_frames.first(max_frames).each do |frame|
        if frame =~ /(?:#{Regexp.escape(Rails.root.to_s)}\/)?(app\/.*):(\d+)/
          file_path = Rails.root.join($1).to_s
          line_no   = $2.to_i

          next unless File.exist?(file_path)

          file_lines = File.readlines(file_path)
          start  = [line_no - 5, 0].max
          finish = [line_no + 4, file_lines.size - 1].min

          context = file_lines[start..finish].map.with_index(start + 1) do |line, i|
            {
              number: i,
              code: line.chomp,
              highlighted: (i == line_no)
            }
          end

          snippets << {
            file: file_path.sub("#{Rails.root}/", ""),
            line: line_no,
            context: context
          }
        end
      end

      snippets.compact
    end

  end
end

require "faulty/name_resolver"
require "faulty/engine"

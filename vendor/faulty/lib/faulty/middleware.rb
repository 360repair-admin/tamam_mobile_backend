module Faulty
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      request = ActionDispatch::Request.new(env)

      @app.call(env)
    rescue => e
      unless e.instance_variable_defined?(:@faulty_handled)
        safe_context = extract_context(env)
        Faulty.capture(e, context: safe_context, request_id: request.uuid)
        e.instance_variable_set(:@faulty_handled, true)
      end
      raise
    end

    private

    def extract_context(env)
      request = ActionDispatch::Request.new(env)
      {
        path: request.fullpath,
        method: request.request_method,
        params: request.filtered_parameters,
        ip: request.remote_ip,
        user_agent: request.user_agent,
        current_user: Faulty.current_faulty_user.call(self)
      }
    end
  end
end

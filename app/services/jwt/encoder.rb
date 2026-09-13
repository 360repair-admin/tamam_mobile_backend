module Jwt
  class Encoder
    SECRET = Rails.application.secret_key_base
    SESSION_DURATION = 24.hours

    def self.call(customer)
      session = customer.auth_sessions.create!(
        jti: SecureRandom.uuid,
        expires_at: SESSION_DURATION.from_now
      )

      payload = {
        sub: customer.id,
        jti: session.jti,
        exp: session.expires_at.to_i
      }

      JWT.encode(payload, SECRET, "HS256")
    end
  end
end

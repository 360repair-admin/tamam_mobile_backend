module Jwt
  class Encoder
    SECRET = Rails.application.secret_key_base

    def self.call(customer)
      payload = {
        sub: customer.id,
        exp: 24.hours.from_now.to_i
      }

      JWT.encode(payload, SECRET, "HS256")
    end
  end
end

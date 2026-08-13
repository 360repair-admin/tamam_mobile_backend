module Jwt
  class Decoder
    SECRET = Rails.application.credentials.secret_key_base

    def self.call(token)
      payload, = JWT.decode(token, SECRET, true, algorithm: "HS256")
      payload
    end
  end
end

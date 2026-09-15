module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_customer!
  end

  private

  def authenticate_customer!
    authorization = request.headers["Authorization"]

    unless authorization&.start_with?("Bearer ")
      return unauthorized("missing_token", "Authentication token is required")
    end

    token = authorization.delete_prefix("Bearer ").strip

    return unauthorized("missing_token", "Authentication token is required") if token.blank?

    payload = Jwt::Decoder.call(token)

    @current_session = AuthSession.find_by(jti: payload["jti"])

    unless @current_session
      return unauthorized("invalid_token", "Invalid access token")
    end

    if @current_session.revoked?
      return unauthorized("session_revoked", "Session has been revoked")
    end

    if @current_session.expired?
      return unauthorized("token_expired", "Access token has expired")
    end

    @current_customer = @current_session.user

    if @current_customer.deleted_at.present?
      unauthorized("customer_deactivated", "This account has been deactivated")
    end
  rescue JWT::ExpiredSignature
    unauthorized("token_expired", "Access token has expired")
  rescue JWT::DecodeError, ActiveRecord::RecordNotFound
    unauthorized("invalid_token", "Invalid access token")
  end

  def current_customer
    @current_customer
  end

  def current_session
    @current_session
  end

  def unauthorized(code = "unauthorized", message = "Authentication required")
    render json: {
      error: {
        code: code,
        message: message
      }
    }, status: :unauthorized
  end
end

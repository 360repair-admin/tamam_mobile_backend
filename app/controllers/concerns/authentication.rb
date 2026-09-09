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

    @current_customer = Customer.find(payload["sub"])

    if @current_customer.deleted_at.present?
      return unauthorized("customer_deactivated", "This account has been deactivated")
    end
  rescue JWT::ExpiredSignature
    unauthorized("token_expired", "Access token has expired")
  rescue JWT::DecodeError, ActiveRecord::RecordNotFound
    unauthorized("invalid_token", "Invalid access token")
  end

  def current_customer
    @current_customer
  end

  def unauthorized(code = "unauthorized", message = "Authentication required")
    render json: {
      error: { code: code, message: message }
    }, status: :unauthorized
  end
end

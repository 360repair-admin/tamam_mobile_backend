class Api::V1::Auth::OtpController < Api::BaseController
  skip_before_action :authenticate_customer!, only: [:create, :verify]

  MAX_ATTEMPTS = 5
  OTP_PURPOSES = %w[login profile_edit payment].freeze

  def create
    unless OTP_PURPOSES.include?(otp_params[:purpose])
      return render_error("invalid_purpose", "Invalid OTP purpose")
    end

    if otp_params[:phone_number].blank?
      return render_error("invalid_phone_number", "Phone number is required")
    end

    otp = SecureRandom.random_number(10_000).to_s.rjust(4, "0")

    otp_request = OtpRequest.create!(
      phone_number: otp_params[:phone_number],
      purpose: otp_params[:purpose],
      code_digest: Digest::SHA256.hexdigest(otp),
      request_id: SecureRandom.uuid,
      expires_at: 5.minutes.from_now,
      attempts: 0
    )

    response = {
      request_id: otp_request.request_id,
      retry_after_seconds: 60
    }

    # TODO: Replace with SMS provider
    response[:otp] = otp if Rails.env.development?

    render json: response, status: :accepted
  end

  def verify
    otp_request = OtpRequest.find_by(
      request_id: verify_params[:request_id],
      phone_number: verify_params[:phone_number]
    )

    unless otp_request
      return render_error("invalid_otp_request", "Invalid OTP request")
    end

    if otp_request.consumed_at.present?
      return render_error("otp_already_used", "OTP has already been used")
    end

    if otp_request.expires_at < Time.current
      return render_error("otp_expired", "OTP has expired")
    end

    if otp_request.attempts >= MAX_ATTEMPTS
      return render_error("otp_attempts_exceeded", "Maximum OTP attempts exceeded")
    end

    digest = Digest::SHA256.hexdigest(verify_params[:code].to_s)

    unless ActiveSupport::SecurityUtils.secure_compare(
      otp_request.code_digest,
      digest
    )
      otp_request.increment!(:attempts)

      return render_error("invalid_otp", "Invalid OTP")
    end

    begin
      ActiveRecord::Base.transaction do
        otp_request.update!(consumed_at: Time.current)
    
        customer = Customer.find_or_create_by!(phone_number: otp_request.phone_number) do |customer|
          customer.phone_number_verified_at = Time.current
        end
    
        token = Jwt::Encoder.call(customer)
    
        render json: { access_token: token, customer: customer }
      end
    rescue
      return render_error("customer_creation_failed", "Unable to create customer")
    end
  end

  private

  def otp_params
    params.permit(:phone_number, :purpose)
  end

  def verify_params
    params.permit(:phone_number, :request_id, :code)
  end

  def render_error(code, message)
    render json: {
      error: {
        code: code,
        message: message
      }
    }, status: :unprocessable_entity
  end
end

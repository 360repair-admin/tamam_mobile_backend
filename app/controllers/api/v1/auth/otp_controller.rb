class Api::V1::Auth::OtpController < Api::BaseController
  skip_before_action :authenticate_customer!, only: [:create, :verify]

  MAX_ATTEMPTS = 5
  OTP_PURPOSES = %w[signup login profile_edit payment].freeze

  def create
    unless OTP_PURPOSES.include?(otp_params[:purpose])
      return render_error("invalid_purpose")
    end

    phone_number = PhoneNumber.normalize(otp_params[:phone_number])

    unless PhoneNumber.valid?(phone_number)
      return render_error("invalid_phone_number")
    end

    if otp_params[:purpose] == "login"
      customer = Customer.find_by(phone_number: phone_number)

      unless customer
        return render_error("customer_not_found")
      end

      if customer.deleted_at.present?
        return render_error("customer_deactivated")
      end
    end

    response = Otp::Request.call(
      phone_number: phone_number,
      purpose: otp_params[:purpose]
    )

    render json: response, status: :accepted
  end

  def verify
    phone_number = PhoneNumber.normalize(verify_params[:phone_number])

    unless PhoneNumber.valid?(phone_number)
      return render_error("invalid_phone_number")
    end

    otp_request = OtpRequest.find_by(
      request_id: verify_params[:request_id],
      phone_number: phone_number
    )

    unless otp_request
      return render_error("invalid_otp_request")
    end

    if otp_request.consumed_at.present?
      return render_error("otp_already_used")
    end

    if otp_request.expires_at < Time.current
      return render_error("otp_expired")
    end

    if otp_request.attempts >= MAX_ATTEMPTS
      return render_error("otp_attempts_exceeded")
    end

    digest = Digest::SHA256.hexdigest(verify_params[:code].to_s)

    unless ActiveSupport::SecurityUtils.secure_compare(
      otp_request.code_digest,
      digest
    )
      otp_request.increment!(:attempts)

      return render_error("invalid_otp")
    end

    begin
      ActiveRecord::Base.transaction do
        otp_request.update!(consumed_at: Time.current)

        customer = Customer.find_by!(
          phone_number: otp_request.phone_number
        )

        customer.update!(
          phone_number_verified_at: Time.current
        )

        token = Jwt::Encoder.call(customer)

        render json: {
          access_token: token,
          customer: customer
        }
      end
    rescue => e
      Rails.logger.error("OTP verification failed: #{e.class}: #{e.message}")
      Rails.logger.error(e.backtrace.join("\n"))

      if Rails.env.production?
        render_error("customer_creation_failed", "Unable to create customer")
      else
        render_error("customer_creation_failed", "#{e.class}: #{e.message}")
      end
    end
  end

  private

  def otp_params
    params.permit(:phone_number, :purpose)
  end

  def verify_params
    params.permit(:phone_number, :request_id, :code)
  end

  def render_error(code)
    render json: {
      error: {
        code: code, message: I18n.t("errors.#{code}")
      }
    }, status: :unprocessable_entity
  end
end

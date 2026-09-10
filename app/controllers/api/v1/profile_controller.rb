module Api
  module V1
    class ProfileController < Api::BaseController
      def show
        render json: { customer: current_customer }
      end

      def update
        current_customer.update!(profile_params)
        render json: { customer: current_customer }
      end

      def destroy
        phone_number = current_customer.phone_number

        otp_request = OtpRequest.find_by(
          request_id: params[:request_id],
          phone_number: phone_number,
          purpose: "account_deletion"
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

        if otp_request.attempts >= 5
          return render_error("otp_attempts_exceeded")
        end

        digest = Digest::SHA256.hexdigest(params[:code].to_s)

        unless ActiveSupport::SecurityUtils.secure_compare(
          otp_request.code_digest,
          digest
        )
          otp_request.increment!(:attempts)
          return render_error("invalid_otp")
        end

        otp_request.update!(consumed_at: Time.current)
        current_customer.update!(deleted_at: Time.current)

        render json: { message: "Account deleted successfully" }, status: :ok
      end

      def request_deletion_otp
        otp_response = Otp::Request.call(
          phone_number: current_customer.phone_number,
          purpose: "account_deletion"
        )

        render json: otp_response, status: :accepted
      end

      private

      def profile_params
        params.permit(:full_name, :email, :locale)
      end

      def render_error(code)
        render json: {
          error: {
            code: code, message: I18n.t("errors.#{code}")
          }
        }, status: :unprocessable_entity
      end
    end
  end
end

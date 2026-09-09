class Otp::Request
  EXPIRY = 5.minutes
  RETRY_AFTER = 60.seconds

  def self.call(phone_number:, purpose:)
    new(phone_number: phone_number, purpose: purpose).call
  end

  def initialize(phone_number:, purpose:)
    @phone_number = phone_number
    @purpose = purpose
  end

  def call
    otp = SecureRandom.random_number(10_000).to_s.rjust(4, "0")

    otp_request = OtpRequest.create!(
      phone_number: @phone_number,
      purpose: @purpose,
      code_digest: Digest::SHA256.hexdigest(otp),
      request_id: SecureRandom.uuid,
      expires_at: EXPIRY.from_now,
      attempts: 0
    )

    sms_enabled = send_sms?

    send_sms(otp) if sms_enabled

    response = {
      request_id: otp_request.request_id,
      retry_after_seconds: RETRY_AFTER
    }

    response[:otp] = otp unless sms_enabled

    response
  end

  private

  def send_sms(otp)
    SmsMessage.create!(
      phone_number: @phone_number,
      message: "Your TAMAM verification code is #{otp}.",
      sms_provider: SmsMessage::SMS_PROVIDER,
      sender_id: SmsMessage::SENDER_ID
    )
  end

  def send_sms?
    ActiveModel::Type::Boolean.new.cast(ENV["SEND_SMS"])
  end
end

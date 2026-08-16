class SendSmsJob < ApplicationJob
  queue_as :default

  def perform(sms_message_id)
    sms_message = SmsMessage.find(sms_message_id)

    UnifonicSmsService.new(sms_message: sms_message).call

    sms_message.update!(
      sent_at: Time.current
    )
  rescue StandardError => e
    sms_message.update!(
      failed_attempts: sms_message.failed_attempts + 1,
      failed_at: Time.current
    )

    raise e
  end
end

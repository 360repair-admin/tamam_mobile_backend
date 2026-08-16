class SmsMessage < ApplicationRecord
  SMS_PROVIDER = "unifonic"
  SENDER_ID = "360 RN"

  belongs_to :sms_template, optional: true

  validates :phone_number, :message, :sms_provider, :sender_id, presence: true

  validates :failed_attempts, numericality: { greater_than_or_equal_to: 0 }

  after_create_commit :enqueue_sms

  private

  def enqueue_sms
    SendSmsJob.perform_later(id)
  end
end

class SmsTemplate < ApplicationRecord
  has_many :sms_messages, dependent: :restrict_with_exception

  validates :name_en, :name_ar, :message_body_en, :message_body_ar, :unique_name, presence: true

  validates :unique_name, uniqueness: true
end

class UnifonicSmsService
  UNIFONIC_URL = URI("https://el.cloud.unifonic.com/rest/SMS/messages")

  HEADERS = {
    "Accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded"
  }

  def initialize(sms_message:)
    @sms_message = sms_message
  end

  def call
    payload = {
      AppSid: ENV.fetch("UNIFONIC_APP_SID"),
      SenderID: @sms_message.sender_id,
      Body: @sms_message.message,
      Recipient: @sms_message.phone_number.delete_prefix("+"),
      CorrelationID: "TAMAM#{@sms_message.id}",
      async: false,
      responseType: :JSON,
      baseEncode: true,
      MessageType: 3,
      statusCallback: :sent
    }

    response = HTTParty.post(
      UNIFONIC_URL,
      body: payload,
      headers: HEADERS
    )

    return true if response["success"]
    return true if response["errorCode"] == "ER-58"

    raise "Unifonic SMS failed: #{response.parsed_response}"
  end
end

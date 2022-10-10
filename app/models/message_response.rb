class MessageResponse

  def initialize(messages)
    @messages = messages
  end

  def as_json
    messages.map do |message|
      {
        number: message._source.number,
        body: message._source.body
      }
    end
  end

  def as_db_json
    messages.map do |message|
      {
        number: message.number,
        body: message.body,
        chat_number: message.chat_number
      }
    end
  end

  private
  attr_reader :messages
end

class ChatResponse
  def initialize(chats)
    @chats = chats
  end

  def as_json
    chats.map do |chat|
      {
        number: chat.number,
        application_token: chat.application_token,
        messages_count: chat.messages_count
      }
    end
  end

  private
  attr_reader :chats
end

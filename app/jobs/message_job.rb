class MessageJob < ApplicationJob
  queue_as :default

  def perform(body)
    messageReq = JSON.parse(body)
    chat = Chat.find_by_id(messageReq['chat_id']).lock!
    messageNumber = Message.where(chat: chat).maximum(:number)?
                      Message.where(chat: chat).maximum(:number)+1 :  1;
    message = Message.new()
    message.chat = chat
    message.number = messageNumber
    message.body = messageReq['body']
    message.save
  end
end

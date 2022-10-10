class ChatJob < ApplicationJob
  queue_as :default

  def perform(token)
    application = Application.find_by_token(token).lock!
    chatNumber = Chat.where(application: application).maximum(:number)?
                   Chat.where(application: application).maximum(:number)+1 :  1;
    chat = Chat.new()
    chat.number = chatNumber
    chat.application = application
    chat.save
  end
end

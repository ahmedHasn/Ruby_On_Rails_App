namespace :job_scheduler do
  desc "Update chats_count for each application as well as messages_count for each chat"
  task update_chats_count_messages_count: :environment do
    Application.all.each do |app|
      app.chats_count = Chat.where(application_id: app.id).count;
      app.save
    end
    Chat.all.each do |chat|
      chat.messages_count = Message.where(chat_id: chat.id).count;
      chat.save
    end
  end

end

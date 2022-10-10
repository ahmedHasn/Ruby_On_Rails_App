class AddDefaultValueToChatsCountAndMessagesCountColumns < ActiveRecord::Migration[7.0]
  def change
    change_column :applications, :chats_count, :integer, default: 0
    change_column :chats, :messages_count, :integer, default: 0
  end
end

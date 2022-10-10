class AddUniqueConstrainToMessages < ActiveRecord::Migration[7.0]
  def change
    add_index :messages, [:number, :chat_id], unique: true
  end
end

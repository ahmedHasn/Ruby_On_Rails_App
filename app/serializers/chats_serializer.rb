class ChatsSerializer < ActiveModel::Serializer
  attributes :number, :application_id, messages_count
end

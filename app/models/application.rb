class Application < ApplicationRecord
  has_many :chats
  validates :name, :presence => true
end

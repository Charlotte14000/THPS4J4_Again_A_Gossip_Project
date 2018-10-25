class User < ApplicationRecord
  belongs_to :city
  has_many :gossips
  has_many :private_messages
  has_many :private_message_recipients
  has_many :comments
end

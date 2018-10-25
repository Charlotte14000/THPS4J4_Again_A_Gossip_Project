class PrivateMessage < ApplicationRecord
  belongs_to :sender, class_name: "User"
  has_many :private_message_receivers
  has_many :receivers, class_name: "User", through: :private_message_receivers
end

class User < ApplicationRecord
  has_many :messages, dependent: :destroy
  validates :password, presence: true, confirmation: true

  def login
    key = SecureRandom.hex(13)
    Session.create(session_key: key, content: {user_id: id}.to_json)
    key
  end
end

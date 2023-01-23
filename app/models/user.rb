class User < ApplicationRecord

  # Userが複数のTaskクラスに属している。
  # Userが削除された場合に、関連付けられているtaskも削除(dependent: :destroy)される
  has_many :tasks, dependent: :destroy

  # Userが複数のLabelクラスに属している。
  # Userが削除された時にそれに紐づく、Labelも削除される（dependent: :destroy）
  # has_many :labels, dependent: :destroy

  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },uniqueness: true,
  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password,presence: true, length: { minimum: 6 }
end

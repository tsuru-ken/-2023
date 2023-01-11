class Task < ApplicationRecord
  validates :title, presence: true,length:{in:1..30}
  validates :content, presence: true,length:{in:1..140}

  scope :sort_limit, -> {order(limit: :desc)}
end

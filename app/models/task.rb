class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true,length:{in:1..30}
  validates :content, presence: true,length:{in:1..140}
  validates :limit, presence: true
  validates :status, presence: true
  validates :priority, presence: true

  enum priority: { low: 0, medium: 1, high: 2 }
  enum status: { not_started: 0, in_progress: 1, completed: 2 }

  scope :default_order, -> { order(created_at: :DESC) }
  scope :sort_limit, -> {order(limit: :asc)}
  scope :sort_priority, -> { order(priority: :DESC) }
  scope :search_status, ->(status) {
    return if status.blank?
    where(status: status) }


  scope :search_title, ->(title) {
    return if title.blank?
    where('title LIKE ?',"%#{title}%") }

end

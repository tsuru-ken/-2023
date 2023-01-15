class Task < ApplicationRecord
  validates :title, presence: true,length:{in:1..30}
  validates :content, presence: true,length:{in:1..140}


  # enum優先度・ステータス用
  enum priority: { low: 0, medium: 1, high: 2 }
  enum status: { not_started: 0, in_progress: 1, completed: 2 }

  # scope検索・ソート機能用
  scope :default_order, -> { order(created_at: :DESC) }
  scope :sort_limit, -> {order(limit: :asc)}
  scope :sort_priority, -> { order(priority: :DESC) }
  scope :search_status, ->(status) {
    return if status.blank?
    where(status: status) }
  scope :search_title, ->(title) {
    return if title.blank?
    where('title LIKE ?',"%#{title}%") }
  # scope :search_label, ->(label) {
    # return if label.blank?
    # pluckよりselect(副問合せ)を使った方がSQL文が一行で済むので稼働コストが良い
    # where(id: labelTask.where(label_id: label).select(:task_id))}
end

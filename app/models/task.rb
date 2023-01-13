class Task < ApplicationRecord
  validates :title, presence: true,length:{in:1..30}
  validates :content, presence: true,length:{in:1..140}


  # enum優先度・ステータス用
  enum priority: { 低: 0, 中: 1, 高: 2 }
  enum status: {未着手: 0, 着手中: 1, 完了: 2}

  # scope検索・ソート機能用
  scope :sort_limit, -> {order(limit: :asc)}
  scope :search_status, ->(status){
    return if status.blank?
    where(status: status) }
  scope :search_title, ->(title){
    return if title.blank?
    where('title LIKE ?',"%#{title}%") }
end

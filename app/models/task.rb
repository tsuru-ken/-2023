class Task < ApplicationRecord

  # Taskクラスが１つのUserクラスに所属している
  # TaskLクラスとUserクラスを紐付けできる
  belongs_to :user

  # Taskが複数のLabelクラスに属している。
  # 中間テーブルであるtask_labelsを経由して、TaskクラスとLabelクラスを紐付けできる。
  has_many :labels, through: :task_labels

  # Taskが複数のTaskLabelクラスに属している。
  # Taskが削除された時にそれに紐づく、TaskLabelも削除される（dependent: :destroy）
  has_many :task_labels, dependent: :destroy

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

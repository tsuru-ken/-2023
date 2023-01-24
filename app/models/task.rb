class Task < ApplicationRecord

  # Taskクラスが１つのUserクラスに所属している
  # TaskLクラスとUserクラスを紐付けできる
  belongs_to :user
  # Taskが複数のTaskLabelクラスに属している。
  # Taskが削除された時にそれに紐づく、TaskLabelも削除される（dependent: :destroy）
  has_many :task_labels, dependent: :destroy

  # Taskが複数のLabelクラスに属している。
  # 中間テーブルであるtask_labelsを経由して、TaskクラスとLabelクラスを紐付けできる。
  has_many :labels, through: :task_labels


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

  # 引数として渡した、'status'を使用して、Taskモデルのstatusと一致するTaskを検索
  scope :search_status, ->(status) {
    # 渡された引数が空白の場合scopeから抜ける
    return if status.blank?
    # Taskモデルからstatusが渡された、'status'に一致するレコードを検索
    where(status: status) }
    # 引数に渡した、'status'に関連したTaskを検索するためのscope

    # 引数として渡した、'title'を使用して、Taskモデルのtitleと一致するTaskを検索
  scope :search_title, ->(title) {
    # 渡された引数が空白の場合scopeから抜ける
    return if title.blank?
    # Taskモデルからtitleが渡された'title'を含むレコードを検索。’LIKE’はSQL文で、部分一致検索するため。 '%'はワイルドカードで、任意の文字列を表示
    # "%#{title}%"で、渡されたtitleを含む任意の文字列を表示
    where('title LIKE ?',"%#{title}%") }

  # 引数として渡した、'label'を使用して、Taskモデルのlabelと一致するTaskを検索
  scope :search_label, ->(label) {
    # ’label'が空白の場合、scopeから抜ける
    return if label.blank?
    # binding.pry
    # 中間テーブル（task_label）を使用して、Label_idが渡された、’Label’に一致するTask_idを所得、それを使用して、Taskモデルから対応するレコードを検索
    where(id: task_label.where(label_id: label).select(:task_id))}
end

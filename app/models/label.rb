class Label < ApplicationRecord
  # Labelが複数のTaskLabelクラスに属している。
  # Label が削除された時にそれに紐づく、TaskLabelも削除される（dependent: :destroy）
  has_many :task_labels, dependent: :destroy

  # Labelが複数のUserクラスに属している。
  # 中間テーブルであるtask_labelsを経由して、LabelクラスとUserクラスを紐付けできる。
  has_many :users,through: :task_labels

  # Labelクラスが１つのUserクラスに所属している
  # LabelクラスとUserクラスを紐付けできる
  belongs_to :user

  # Labelクラスのインスタンス作成時に、name属性の値が必須
  validates :name, presence: true
end

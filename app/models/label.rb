class Label < ApplicationRecord
  # Labelが複数のTaskLabelクラスに属している。
  # Label が削除された時にそれに紐づく、TaskLabelも削除される（dependent: :destroy）
  has_many :task_labels, dependent: :destroy

  # Labelが複数のTaskクラスに属している。
  # 中間テーブルであるtask_labelsを経由して、LabelクラスとTaskクラスを紐付けできる。
  has_many :tasks,through: :task_labels

end

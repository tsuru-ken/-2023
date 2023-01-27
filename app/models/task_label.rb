class TaskLabel < ApplicationRecord

  # TaskLabelクラスが１つのTaskクラスに所属している
  # TaskLabelクラスとTaskクラスを紐付けできる
  belongs_to :task

  # TaskLabelクラスが１つのLabelクラスに所属している
  # TAskLabelクラスとLabelクラスを紐付けできる
  belongs_to :label
end

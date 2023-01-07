FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :task do
    title { 'タスクネーム1' }
    content { 'タスク内容１' }
    limit {'2023/01/10'}
    status {'完了'}
    priority {'高'}
  end
  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :second_task, class: Task do
    title { 'タスクネーム2' }
    content { 'タスク内容2' }
    limit {'2023/01/11'}
    status {'未着手'}
    priority {'中'}
  end
end
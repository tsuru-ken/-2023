FactoryBot.define do
  factory :task do
    title { 'タスクネーム１' }
    content { 'タスク内容１' }
    limit {'2023/01/7'}
    status {'完了'}
    priority {'高'}
  end

  factory :second_task, class: Task do
    title { 'タスクネーム２' }
    content { 'タスク内容２' }
    limit {'2023/01/8'}
    status {'未着手'}
    priority {'中'}
  end
end

User.create!(
  email: "takeshi@takeshi.com",
  name: "たけし太郎",
  password: "123456",
  admin: true)

User.create!(
  email: "task@task.com",
  name: "タスク太郎",
  password: "123456")

10.times do |n|
  Label.create!(label_name: "Jリーグ#{n + 1}")
end
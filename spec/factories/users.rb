FactoryBot.define do
  factory :admin_user, class: User do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    name { "adminuser1" }
    email { "admin@admin.com" }
    password { "123456" }
    password_confirmation { "123456"}
    admin {true}
  end

  factory :user do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    name { "user1" }
    email { "user1@user.com" }
    password { "123456" }
    password_confirmation { "123456"}
    admin {false}
  end
end
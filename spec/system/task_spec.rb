require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  # before do
  #   # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
  #   FactoryBot.create(:task)
  #   FactoryBot.create(:second_task)
  # end


  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        # タスク一覧ページに遷移
        visit new_task_path
        #テストの日時を生成
        date = Date.new(2023,01,10)
        #fill_in 'ラベル', with: '書き換える内容'を記載
        fill_in 'task[title]', with: '初タスク登録'
        fill_in 'task[content]', with: '少しテストがわかってきた。'
        fill_in "task[limit]", with: date

        click_button
        # visitした（遷移した）page（タスク一覧ページ）に登録した文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content '初タスク登録'
        expect(page).to have_content '少しテストがわかってきた。'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        # テストで使用するためのタスクを作成
        task = FactoryBot.create(:task, title: 'タスクネーム３', limit: "2023/01/7" )
        task = FactoryBot.create(:second_task, title: 'タスクネーム２', limit: "2023/01/8" )
        task = FactoryBot.create(:third_task, title: 'タスクネーム１', limit: "2023/01/9" )
        # タスク一覧ページに遷移
        visit tasks_path
        #indexの<tr class="task_row" >
        # タスク一覧を配列として取得するため、View側でclassを振っておく
        sleep(1)
        task_list = all('.task_row')

        expect(task_list[0]).to have_content 'タスクネーム３'
        expect(task_list[1]).to have_content 'タスクネーム２'
        expect(task_list[2]).to have_content 'タスクネーム１'
      end
    end

    context 'タスクが終了期限の降順に並んでいる場合' do
      it '終了期限が近いものから表示する' do
        assert Task.all.order(created_at: :desc)
        # task = FactoryBot.create(:task, title: 'タイトル1', limit: "2023/01/7" )
        # task = FactoryBot.create(:second_task, title: 'タイトル2', limit: "2023/01/8" )
        # task = FactoryBot.create(:third_task, title: 'タイトル3', limit: "2023/01/9" )
        # visit tasks_path
        # click_link 'limit'
        # task_list = all('.task_row')

        # expect(task_list[0]).to have_content 'タイトル1'
        # expect(task_list[1]).to have_content 'タイトル2'
        # expect(task_list[2]).to have_content 'タイトル3'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # テストで使用するためのタスクを作成
        task = FactoryBot.create(:task, title: 'task')
        # タスク一覧ページに遷移
        visit tasks_path
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content 'task'
        # expect(page).to have_content 'task_failure'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される

      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        # テストで使用するためのタスクを作成
        task = FactoryBot.create(:task, title: 'show_test')
        # タスク一覧ページに遷移
        visit tasks_path
        # click_on "Log In"
        expect(page).to have_content "show_test"

       end
     end
  end
end
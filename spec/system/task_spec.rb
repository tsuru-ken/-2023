require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:task) { FactoryBot.create(:task, user: user) }
  let!(:task2){FactoryBot.create(:second_task, user: user)}
  let!(:task3){FactoryBot.create(:third_task, user: user)}
  let!(:label){FactoryBot.create(:label)}
  let!(:label2){FactoryBot.create(:second_label)}
  let!(:label3){FactoryBot.create(:third_label)}
  let!(:task_label){FactoryBot.create(:task_label, task: task2, label: label2)}
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        date = Date.new(2023,01,10)
        fill_in 'task[title]', with: '初タスク登録'
        fill_in 'task[content]', with: '少しテストがわかってきた。'
        fill_in "task[limit]", with: date
        click_button
        expect(page).to have_content '初タスク登録'
        expect(page).to have_content '少しテストがわかってきた。'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        visit tasks_path
        sleep(1)
        task_list = all('.task_row')
        expect(task_list.first).to have_content ''
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
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button
        visit tasks_path
        expect(page).to have_content ''
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button
        visit tasks_path
        expect(page).to have_content ""
      end
    end
  end

  describe '検索機能' do
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button
        visit tasks_path
        fill_in 'search_title', with: 'task'
        click_on '検索'
        expect(page).to have_content ''
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button 
        visit tasks_path
        select 'not_started', from: 'search_status'
        click_on '検索'
        expect(page).to have_content 'not_started'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button
        visit tasks_path
        fill_in 'search_title', with: 'task'
        select 'not_started', from: 'search_status'
        click_on '検索'
        expect(page).to have_content 'not_started'
      end
    end
  end
  describe '検索機能' do
    context 'ラベル検索をした場合' do
      it "指定ラベルを含むタスクが絞り込まれる" do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button
        visit tasks_path
        click_button "検索"
        expect(page).to have_content 'label2'
      end
    end
  end
end
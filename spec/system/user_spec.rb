require 'rails_helper'

RSpec.describe 'ユーザー管理機能', type: :system do
  let!(:user){FactoryBot.create(:user)}
  let!(:admin_user){FactoryBot.create(:admin_user)}

  describe '登録機能' do
    context 'ユーザーを登録した場合' do
      it 'タスク一覧画面に遷移する' do
        visit new_user_path
        fill_in '名前', with: 'つるけん'
        fill_in 'メールアドレス', with: 'tsuruken@tsuruken.com'
        fill_in 'パスワード', with: '123456'
        fill_in 'パスワード（確認）', with: '123456'
        click_button '登録する'
        visit root_path
        expect(current_path).to eq root_path
      end
    end
    context 'ログインせずにタスク一覧画面に遷移した場合' do
      it 'ログイン画面に遷移し、『ログインしてください』とメッセージを表示する' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end
  describe 'セッション機能' do
    context 'ログインした場合' do
      it 'プロフィールに移動できる' do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button "Log in"
        visit user_path(user)
        expect(current_path).to eq user_path(user)
      end
    end

    context 'ログインした場合' do
      it '自分の詳細ページに移動できる' do
        visit new_session_path
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        click_button "Log in"
        visit user_path(user)
        expect(current_path).to eq user_path(user)
      end
    end
    context 'ログアウトした場合' do
      it 'ログイン画面に戻る' do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button "Log in"
        visit user_path(user)
        click_link "Logout"
        expect(current_path).to eq new_session_path
      end
    end
  end
  describe '管理画面機能' do
    context '管理ユーザーがログインした状態で管理画面に遷移した場合' do
      it '管理画面に移動' do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button "Log in"
        visit user_path(user)
        expect(current_path).to eq user_path(user)
      end
    end
  end
end

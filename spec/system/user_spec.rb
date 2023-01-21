require 'rails_helper'

RSpec.describe 'ユーザー管理機能', type: :system do
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
  
end
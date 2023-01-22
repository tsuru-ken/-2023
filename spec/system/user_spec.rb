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
        fill_in 'session[email]', with: admin_user.email
        fill_in 'session[password]', with: admin_user.password
        click_button "Log in"
        visit admin_users_path
        expect(current_path).to eq admin_users_path
      end
    end

    context '一般ユーザーがログインした状態で、管理画面に移動した場合' do
      it '管理画面に移動できない' do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button "Log in"
        visit admin_users_path
        expect(current_path).not_to eq admin_users_path
      end
    end

    context '管理ユーザーがユーザーの新規登録をした場合' do
      it 'ユーザーがユーザー一覧に表示される' do
        visit new_session_path
        fill_in 'session[email]', with: admin_user.email
        fill_in 'session[password]', with: admin_user.password
        click_button "Log in"
        visit admin_users_path
        click_on "ユーザーを登録する"
        fill_in 'user[name]', with: 'tsuruken2'
        fill_in 'user[email]', with: 'tsuruken2@gmail.com'
        fill_in 'user[password]', with: '123456'
        fill_in 'user[password_confirmation]', with: '123456'
        select false, from: :user_admin
        click_button "登録する"
        visit admin_users_path
        expect(page).to have_content 'tsuruken2'
      end
    end

    context '管理ユーザーがユーザーの詳細画面にアクセスした場合' do
      it 'ユーザーの詳細画面が表示される' do
        visit new_session_path
        fill_in 'session[email]', with: admin_user.email
        fill_in 'session[password]', with: admin_user.password
        click_button "Log in"
        visit admin_users_path
        visit admin_user_path(user)
        expect(current_path).to eq admin_user_path(user)
      end
    end

    context '管理者はユーザーの編集画面からユーザー編集した場合' do
      it 'ユーザーの詳細画面で編集後の画面が表示される' do
        visit new_session_path
        fill_in 'session[email]', with: admin_user.email
        fill_in 'session[password]', with: admin_user.password
        click_button "Log in"
        visit admin_users_path
        visit edit_admin_user_path(user)
        fill_in 'user[name]', with: user.name
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        fill_in 'user[password_confirmation]', with: user.password
        select false, from: :user_admin
        click_button 
        visit admin_user_path(user)
        expect(page).to have_content user.name
      end
    end

    context '管理ユーザーはユーザーの削除した場合' do
      it 'ユーザーの一覧画面に表示されない' do
        visit new_session_path
        fill_in 'session[email]', with: admin_user.email
        fill_in 'session[password]', with: admin_user.password
        click_button "Log in"
        visit admin_users_path
        first('.btn-outline-danger').click
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content '削除しました'
      end
    end
  end
end

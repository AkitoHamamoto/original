require 'rails_helper'

RSpec.describe "予定投稿機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @plan = FactoryBot.build(:plan)
  end

  context '予定投稿がうまくいく時' do
    it '権限を持っているユーザーは予定を投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 予定を入力する
      fill_in 'plan-text', with: @plan.text
      # 送信ボタンをクリックする
      find('.plan-btn').click
      # トップページに遷移していることを確認する
      expect(current_path).to eq root_path
      # 投稿した連絡が表示されていることを確認する
      expect(page).to have_content(@plan.text)
    end
  end

  context '予定投稿がうまくいかない時' do
    it '権限を持たないユーザーは予定に投稿できない' do
      # トップページに移動する
      visit root_path
      # トップページにサインインする遷移ボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'nickname', with: @user.nickname
      fill_in 'email', with: 'sample2@sin.cos'
      fill_in 'password', with: @user.password
      fill_in 'password-confirmation', with: @user.password_confirmation
      select '1990', from: 'user_birth_date_1i'
      select '9', from: 'user_birth_date_2i'
      select '22', from: 'user_birth_date_3i'
      uncheck 'user_authority'
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページに遷移する
      expect(current_path).to eq root_path
      # トップページに予定の投稿フォームが表示されていないことを確認する
      expect(page).to have_selector ".submit-form"
    end
  end
end

RSpec.describe "予定削除機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @plan = FactoryBot.build(:plan)
  end

  context '予定の削除がうまくいく時' do
    it '権限を持っているユーザーは投稿の削除ができる' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 掲示板に連絡を入力する
      fill_in 'plan-text', with: @plan.text
      # 送信ボタンをクリックする
      find('.plan-btn').click
      # トップページに遷移していることを確認する
      expect(current_path).to eq root_path
      # 投稿した連絡が表示されていることを確認する
      expect(page).to have_content(@plan.text)
      # 投稿したテキストの横に削除ボタンがあることを確認する
      expect(page).to have_content('削除')
      # 削除ボタンをクリックする
      find('.plan-destroy').click
      # 投稿が消えていることを確認する
      expect(page).to have_no_content(@plan.text)
    end
  end

  context '掲示板の削除がうまくいかない時' do
    it '権限を持っていないユーザーには連絡の削除はできない' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 掲示板に連絡を入力する
      fill_in 'plan-text', with: @plan.text
      # 送信ボタンをクリックする
      find('.plan-btn').click
      # トップページに遷移していることを確認する
      expect(current_path).to eq root_path
      # 投稿した連絡が表示されていることを確認する
      expect(page).to have_content(@plan.text)
      # ログアウトする
      find(".logout").click
      # トップページにサインインする遷移ボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'nickname', with: @user.nickname
      fill_in 'email', with: 'sample2@sin.cos'
      fill_in 'password', with: @user.password
      fill_in 'password-confirmation', with: @user.password_confirmation
      select '1990', from: 'user_birth_date_1i'
      select '9', from: 'user_birth_date_2i'
      select '22', from: 'user_birth_date_3i'
      uncheck 'user_authority'
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページに遷移する
      expect(current_path).to eq root_path
      # トップページに削除ボタンが表示されていないことを確認する
      expect(page).to have_no_selector "削除"
    end
  end
end

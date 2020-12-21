require 'rails_helper'

RSpec.describe "店舗情報投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @shop = FactoryBot.build(:shop)
  end

  context '店舗情報がうまく投稿できる時' do
    it '権限を持っているユーザーは店情報を投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 店舗情報入力ページに遷移する
      visit new_shop_path
      # 店舗情報を入力する
      find('#post-image', visible: false).set('app/assets/images/3.png')
      fill_in 'shop-name', with: @shop.name
      fill_in 'shop-postal-code', with: @shop.postal_code
      fill_in 'shop-address', with: @shop.address
      fill_in 'shop-phone-number', with: @shop.phone_number
      fill_in 'shop-text', with: @shop.text
      # サインアップのボタンを押すとショップモデルのカウントが1上がることを確認する
      expect{find('input[name="commit"]').click}.to change { Shop.count }.by(1)
      # トップページに遷移していることを確かめる
      expect(current_path).to eq root_path
      # ユーザー名がトップページに表示されていることを確認する
      expect(page).to have_content (@user.nickname)
      # ユーザー名をクリックする
      find('.user-nickname').click
      # 入力した情報が表示されていることを確認する
      expect(page).to have_content(@shop.name)
      expect(page).to have_content(@shop.postal_code)
      expect(page).to have_content(@shop.address)
      expect(page).to have_content(@shop.phone_number)
      expect(page).to have_content(@shop.text)
    end
  end

  context '店舗情報をうまく投稿できない時' do
    it 'ログインしていないユーザーは店舗情報を投稿できない' do
      # トップページに遷移する
      visit root_path
      # マニュアル投稿ページに遷移しようとして、ログインページに遷移する
      visit new_shop_path
      expect(current_path).to eq new_user_session_path
    end

    it '権限を持っていないユーザーは店舗情報を投稿できない' do
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
      # 店舗情報入力ページに遷移しようとするがトップページに遷移する
      visit new_shop_path
      expect(current_path).to eq root_path
    end
  end
end

RSpec.describe "店舗情報編集", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @shop = FactoryBot.build(:shop)
  end

  context '店舗情報の編集がうまくいく時' do
    it '権限を持つユーザーは店舗情報の編集ができる' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 店舗情報入力ページに遷移する
      visit new_shop_path
      # 店舗情報を入力する
      find('#post-image', visible: false).set('app/assets/images/3.png')
      fill_in 'shop-name', with: @shop.name
      fill_in 'shop-postal-code', with: @shop.postal_code
      fill_in 'shop-address', with: @shop.address
      fill_in 'shop-phone-number', with: @shop.phone_number
      fill_in 'shop-text', with: @shop.text
      # サインアップのボタンを押すとショップモデルのカウントが1上がることを確認する
      expect{find('input[name="commit"]').click}.to change { Shop.count }.by(1)
      # トップページに遷移していることを確かめる
      expect(current_path).to eq root_path
      # ユーザー名がトップページに表示されていることを確認する
      expect(page).to have_content (@user.nickname)
      # ユーザー名をクリックする
      find('.user-nickname').click
      # 入力した情報が表示されていることを確認する
      expect(page).to have_content(@shop.name)
      expect(page).to have_content(@shop.postal_code)
      expect(page).to have_content(@shop.address)
      expect(page).to have_content(@shop.phone_number)
      expect(page).to have_content(@shop.text)
      # 店舗情報編集ページリンクがあることを確認する
      visit new_shop_path
      expect(page).to have_content('編集する')
      find('.edit-shop').click
      # 店舗情報がすでに入力されていることを確認する
      expect(page).to have_content(@shop.name)
      expect(page).to have_content(@shop.postal_code)
      expect(page).to have_content(@shop.address)
      expect(page).to have_content(@shop.phone_number)
      expect(page).to have_content(@shop.text)
      # 店舗情報を編集する
      find('#post-image', visible: false).set('app/assets/images/4.png')
      fill_in 'shop-name', with: 'sample2'
      fill_in 'shop-postal-code', with: '123-4566'
      fill_in 'shop-address', with: 'sample2'
      fill_in 'shop-phone-number', with: '08022222222'
      fill_in 'shop-text', with: 'sample2'
      # サインアップのボタンを押すとショップモデルのカウントが上がるらないことを確認する
      expect{find('input[name="commit"]').click}.to change { Shop.count }.by(0)
      # トップページに遷移していることを確かめる
      expect(current_path).to eq root_path
      # ユーザー名がトップページに表示されていることを確認する
      expect(page).to have_content (@user.nickname)
      # ユーザー名をクリックする
      find('.user-nickname').click
      # 入力した情報が表示されていることを確認する
      expect(page).to have_content('sample2')
      expect(page).to have_content('123-4566')
      expect(page).to have_content('sample2')
      expect(page).to have_content('08022222222')
      expect(page).to have_content('sample2')
    end
  end

  context '店舗情報の編集がうまくいかない時' do
    it '権限を持たないユーザーは店舗情報の編集はできない' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 店舗情報入力ページに遷移する
      visit new_shop_path
      # 店舗情報を入力する
      find('#post-image', visible: false).set('app/assets/images/3.png')
      fill_in 'shop-name', with: @shop.name
      fill_in 'shop-postal-code', with: @shop.postal_code
      fill_in 'shop-address', with: @shop.address
      fill_in 'shop-phone-number', with: @shop.phone_number
      fill_in 'shop-text', with: @shop.text
      # サインアップのボタンを押すとショップモデルのカウントが1上がることを確認する
      expect{find('input[name="commit"]').click}.to change { Shop.count }.by(1)
      # トップページに遷移していることを確かめる
      expect(current_path).to eq root_path
      # ユーザー名がトップページに表示されていることを確認する
      expect(page).to have_content (@user.nickname)
      # ユーザー名をクリックする
      find('.user-nickname').click
      # 入力した情報が表示されていることを確認する
      expect(page).to have_content(@shop.name)
      expect(page).to have_content(@shop.postal_code)
      expect(page).to have_content(@shop.address)
      expect(page).to have_content(@shop.phone_number)
      expect(page).to have_content(@shop.text)
      # ログアウトする
      find(".logout").click
      # 権限を持たないアカウントでログインする
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
      # 店舗情報入力ページに遷移しようとするがトップページに遷移する
      visit new_shop_path
      expect(current_path).to eq root_path
    end
  end

end
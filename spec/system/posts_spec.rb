require 'rails_helper'

RSpec.describe "マニュアル投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.build(:post)
  end

  context 'マニュアル動画が投稿できるとき' do
    it 'ログインしたユーザーはマニュアル投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # MANUAL一覧ページに遷移する
      visit posts_path
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('投稿する')
      # 投稿ページに移動する
      visit new_post_path
      # フォームに情報を入力する
      fill_in 'text-number-id', with: @post.number
      fill_in 'title-name', with: @post.title
      find('#post-video-id', visible: false).set('app/assets/images/1.mp4')
      fill_in 'post-text', with: @post.text
      find('#post-image', visible: false).set('app/assets/images/1.png')
      # 送信するとPostモデルのカウントが1上がることを確認する
      expect{find('input[name="commit"]').click}.to change { Post.count }.by(1)
      # 投稿完了して投稿一覧に遷移することを確認する
      expect(current_path).to eq posts_path
      # 投稿一覧ページには先ほど投稿した内容が存在することを確認する(動画)
      expect(page).to have_selector ".manual-box"
      # 投稿一覧ページには先ほど投稿した内容が存在することを確認する(タイトル)
      expect(page).to have_content (@post.title)
      # 投稿一覧ページには先ほど投稿した内容が存在することを確認する(番号)
      expect(page).to have_content (@post.number)
    end
  end

  context 'ログインしていないとマニュアルページに遷移できない' do
    it 'ログインしていないユーザーはマニュアル投稿ができない' do
      # トップページに遷移する
      visit root_path
      # マニュアル投稿ページに遷移しようとして、ログインページに遷移する
      visit new_post_path
      expect(current_path).to eq new_user_session_path
    end

    it '権限のないユーザーはマニュアル投稿ページに遷移できない' do
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
      # マニュアル投稿ページに遷移しようとするがトップページに遷移する
      visit new_post_path
      expect(current_path).to eq root_path
    end
  end
end

RSpec.describe 'マニュアル編集', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.build(:post)
  end

  context 'マニュアル編集ができるとき' do
    it '権限を持つユーザーがログインしたときマニュアル編集ができる' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # MANUAL一覧ページに遷移する
      visit posts_path
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('投稿する')
      # 投稿ページに移動する
      visit new_post_path
      # フォームに情報を入力する
      fill_in 'text-number-id', with: @post.number
      fill_in 'title-name', with: @post.title
      find('#post-video-id', visible: false).set('app/assets/images/1.mp4')
      fill_in 'post-text', with: @post.text
      find('#post-image', visible: false).set('app/assets/images/1.png')
      # 送信するとPostモデルのカウントが1上がることを確認する
      expect{find('input[name="commit"]').click}.to change { Post.count }.by(1)
      # 投稿完了して投稿一覧に遷移することを確認する
      expect(current_path).to eq posts_path
      # 投稿一覧ページには先ほど投稿した内容が存在することを確認する(動画)
      expect(page).to have_selector ".manual-box"
      # 投稿一覧ページには先ほど投稿した内容が存在することを確認する(タイトル)
      expect(page).to have_content (@post.title)
      # 投稿一覧ページには先ほど投稿した内容が存在することを確認する(番号)
      expect(page).to have_content (@post.number)
      # 投稿動画をクリックしてマニュアル詳細ページに遷移する
      find('.manual-box').click
      # 動画編集ページへのリンクがある
      expect(page).to have_content('編集')
      # 動画編集ページリンクをクリックして遷移する
      find('.post-edit-btn').click
      expect(page).to have_content('マニュアル情報編集')
      # 動画の情報を編集する
      fill_in 'text-number-id', with: "3"
      fill_in 'title-name', with: "sample2"
      find('#post-video-id', visible: false).set('app/assets/images/1.mp4')
      fill_in 'post-text', with: "text2"
      find('#post-image', visible: false).set('app/assets/images/2.png')
      # 送信するとPostモデルのカウントが上がらないを確認する
      expect{find('input[name="commit"]').click}.to change { Post.count }.by(0)
      # 投稿完了して投稿一覧に遷移することを確認する
      expect(current_path).to eq posts_path
      # 投稿一覧ページには変更した投稿した内容が存在することを確認する(動画)
      expect(page).to have_selector ".manual-box"
      # 投稿一覧ページには変更した投稿した内容が存在することを確認する(タイトル)
      expect(page).to have_content('sample2')
      # 投稿一覧ページには変更した投稿した内容が存在することを確認する(番号)
      expect(page).to have_content('3')
    end
  end

  context 'マニュアル編集ができない時' do
    it '権限の持っていないユーザーはマニュアルの編集ができない' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # MANUAL一覧ページに遷移する
      visit posts_path
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('投稿する')
      # 投稿ページに移動する
      visit new_post_path
      # フォームに情報を入力する
      fill_in 'text-number-id', with: @post.number
      fill_in 'title-name', with: @post.title
      find('#post-video-id', visible: false).set('app/assets/images/1.mp4')
      fill_in 'post-text', with: @post.text
      find('#post-image', visible: false).set('app/assets/images/1.png')
      # 送信するとPostモデルのカウントが1上がることを確認する
      expect{find('input[name="commit"]').click}.to change { Post.count }.by(1)
      # 投稿完了して投稿一覧に遷移することを確認する
      expect(current_path).to eq posts_path
      # 投稿一覧ページには先ほど投稿した内容が存在することを確認する(動画)
      expect(page).to have_selector ".manual-box"
      # 投稿一覧ページには先ほど投稿した内容が存在することを確認する(タイトル)
      expect(page).to have_content (@post.title)
      # 投稿一覧ページには先ほど投稿した内容が存在することを確認する(番号)
      expect(page).to have_content (@post.number)
      # トップページに移動する
      visit root_path
      # ログアウトする
      find(".logout").click
      # トップページに権限を持たないアカウントでサインインする遷移ボタンがあることを確認する
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
      # マニュアル一覧ページに遷移する
      visit posts_path
      # 動画をクリックし動画詳細ページに遷移する
      find('.manual-box').click
      # 編集ページに遷移するbpたんがないことを確認する
      expect(page).to have_no_content('編集')
    end
  end
end

RSpec.describe 'マニュアル削除', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.build(:post)
  end

  context 'マニュアル削除がうまくできる時' do
    it '権限を持ったユーザーはマニュアル動画の削除ができる' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # MANUAL一覧ページに遷移する
      visit posts_path
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('投稿する')
      # 投稿ページに移動する
      visit new_post_path
      # フォームに情報を入力する
      fill_in 'text-number-id', with: @post.number
      fill_in 'title-name', with: @post.title
      find('#post-video-id', visible: false).set('app/assets/images/1.mp4')
      fill_in 'post-text', with: @post.text
      find('#post-image', visible: false).set('app/assets/images/1.png')
      # 送信するとPostモデルのカウントが1上がることを確認する
      expect{find('input[name="commit"]').click}.to change { Post.count }.by(1)
      # 投稿完了して投稿一覧に遷移することを確認する
      expect(current_path).to eq posts_path
      # 投稿一覧ページには先ほど投稿した内容が存在することを確認する(動画)
      expect(page).to have_selector ".manual-box"
      # 投稿一覧ページには先ほど投稿した内容が存在することを確認する(タイトル)
      expect(page).to have_content (@post.title)
      # 投稿一覧ページには先ほど投稿した内容が存在することを確認する(番号)
      expect(page).to have_content (@post.number)
      # 投稿動画をクリックしてマニュアル詳細ページに遷移する
      find('.manual-box').click
      # 動画編集ページへのリンクがある
      expect(page).to have_content('削除')
      # 動画編集ページリンクをクリックして遷移する
      find('.post-destroy-btn').click
      # 動画一覧ページに遷移していることを確かめる
      expect(current_path).to eq posts_path
      # 動画がないことを確認する
      expect(page).to have_no_selector ".manual_box"
    end
  end 

  context 'マニュアル削除がうまくできない時' do
    it '権限を持たないユーザーはマニュアル動画を削除できない' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # MANUAL一覧ページに遷移する
      visit posts_path
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('投稿する')
      # 投稿ページに移動する
      visit new_post_path
      # フォームに情報を入力する
      fill_in 'text-number-id', with: @post.number
      fill_in 'title-name', with: @post.title
      find('#post-video-id', visible: false).set('app/assets/images/1.mp4')
      fill_in 'post-text', with: @post.text
      find('#post-image', visible: false).set('app/assets/images/1.png')
      # 送信するとPostモデルのカウントが1上がることを確認する
      expect{find('input[name="commit"]').click}.to change { Post.count }.by(1)
      # 投稿完了して投稿一覧に遷移することを確認する
      expect(current_path).to eq posts_path
      # 投稿一覧ページには先ほど投稿した内容が存在することを確認する(動画)
      expect(page).to have_selector ".manual-box"
      # 投稿一覧ページには先ほど投稿した内容が存在することを確認する(タイトル)
      expect(page).to have_content (@post.title)
      # 投稿一覧ページには先ほど投稿した内容が存在することを確認する(番号)
      expect(page).to have_content (@post.number)
      # トップページに移動する
      visit root_path
      # ログアウトする
      find(".logout").click
      # トップページに権限を持たないアカウントでサインインする遷移ボタンがあることを確認する
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
      # マニュアル削除ページに遷移しようとするがトップページに遷移する
      visit posts_path
      # 動画をクリックし動画詳細ページに遷移する
      find('.manual-box').click
      # 編集ページに遷移するbpたんがないことを確認する
      expect(page).to have_no_content('削除')
    end
  end
end



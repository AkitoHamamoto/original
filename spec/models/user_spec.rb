# require 'rails_helper'

# RSpec.describe User, type: :model do
#   before do
#     @user = FactoryBot.build(:user) 
#   end

#   describe 'ユーザー新規登録' do
#     context '新規登録がうまくいくとき'
#       it '必須項目(nickname, email, password, password_confirmation, birth_date, authority)が存在すればうまくいく' do
#         expect(@user).to be_valid
#       end
#     end

#     context '新規登録がうまくいくとき' do
#       it 'nicknameが空だと登録できない'
#         @user.nickname = ''
#         @user.valid?
#         expect(@user.errors.full_messages).to include("Nickname can't be blank")
#       end

#       it 'emailが空だと登録できない' do
#       end 
#       it '重複したemailが存在する場合登録できない' do
#       end
#       it 'emailが@を含んでいないと登録できない' do
#       end
#       it 'passwordが5文字以下であれば登録できない' do
#       end
#       it 'passwordが半角数字混合でなければ登録できない' do
#       end
#       it 'passwordが全角では登録できない' do
#       end
#       it 'passwordが存在してもpassword_confirmationが空だと登録できない' do
#       end
#       it 'birth_dateが空だと登録できない' do
#       end
#       it 'authorityが' do
#       end
#       it '' do
#       end
#       it '' do
#       end
#     end

#   end

# end

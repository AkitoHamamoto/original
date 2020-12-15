require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @post = FactoryBot.build(:post)
  end

  describe 'マニュアル動画投稿機能' do
    context 'マニュアル情報入力がうまくいくとき' do
      it '必須項目(number, title, text, video, image )が全て記入してあれば投稿できる' do
        expect(@post).to be_valid
      end
    end

    context 'マニュアル情報入力がうまくいくとき' do
      it 'numberが空のとき' do
        @post.number = ''
        @post.valid?
        expect(@post.errors.full_messages).to include("Number can't be blank")
      end
      it 'numberが半角数字でなければ投稿できない' do
        @post.number = 'a'
        @post.valid?
        expect(@post.errors.full_messages).to include()
      end
      it 'numberが重複しているとき投稿できない' do
        @post.save
        anothor_post = FactoryBot.build(:post)
        anothor_post.number = @post.number
        anothor_post.valid?
        expect(anothor_post.errors.full_messages).to include("Number has already been taken")
      end
      it 'textが空のとき' do
        @post.title = ''
        @post.valid?
        expect(@post.errors.full_messages).to include("Title can't be blank")
      end
      it 'videoが空のとき' do
        @post.video = nil
        @post.valid?
        expect(@post.errors.full_messages).to include("Video can't be blank")
      end
      
    end
  end
end

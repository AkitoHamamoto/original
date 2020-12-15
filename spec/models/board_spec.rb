require 'rails_helper'

RSpec.describe Board, type: :model do
  before do
    @board = FactoryBot.build(:board)
  end

  describe 'boardを投稿する' do
    context 'boardがうまくいくとき' do
      it 'textの入力が完了していれば投稿できる' do
        expect(@board).to be_valid
      end
    end

    context 'planがうまくいかないとき' do
      it 'textの入力が完了していれば投稿できる' do
        @board.text = ''
        @board.valid?
        expect(@board.errors.full_messages).to include("Text can't be blank")
      end
    end
  end

end

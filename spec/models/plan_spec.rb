require 'rails_helper'

RSpec.describe Plan, type: :model do
  before do
    @plan = FactoryBot.build(:plan)
  end

  describe 'planを投稿する' do
    context 'planがうまくいくとき' do
      it 'textの入力が完了していれば投稿できる' do
        expect(@plan).to be_valid
      end
    end

    context 'planがうまくいかないとき' do
      it 'textの入力が完了していれば投稿できる' do
        @plan.text = ''
        @plan.valid?
        expect(@plan.errors.full_messages).to include("Text can't be blank")
      end
    end
  end
  
end

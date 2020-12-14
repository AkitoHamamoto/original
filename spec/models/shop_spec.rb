require 'rails_helper'

RSpec.describe Shop, type: :model do
  before do
    @shop = FactoryBot.build(:shop) 
  end

  describe '店舗情報入力' do
    context '店舗情報入力がうまくいくとき' do
      it '必須情報(name, postal_code, adress, phone_number, text, image)があれば保存できる' do
        expect(@shop).to be_valid
      end
    end

    context '店舗情報入力がうまくいかないとき' do
      it 'nameが空だと登録できない' do
        @shop.name = ''
        @shop.valid?
        expect(@shop.errors.full_messages).to include("Name can't be blank")
      end

      it 'postal_codeが空だと登録できない' do
        @shop.postal_code = ''
        @shop.valid?
        expect(@shop.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'adressが空だと登録できない' do
        @shop.address = ''
        @shop.valid?
        expect(@shop.errors.full_messages).to include("Address can't be blank")
      end

      it 'phone_numberが空だと登録できない' do
        @shop.phone_number = ''
        @shop.valid?
        expect(@shop.errors.full_messages).to include("Phone number can't be blank")
      end
      
      it '電話番号が12桁以上だと購入できない' do
        @shop.phone_number = '090123456789'
        @shop.valid?
        expect(@shop.errors.full_messages).to include('Phone number 携帯番号には(-)なしで11桁の数字を入力してください')
      end
      
      it '電話番号は数字のみ（ハイフンが含まれていると）購入できない' do
        @shop.phone_number = '090-1234-5678'
        @shop.valid?
        expect(@shop.errors.full_messages).to include('Phone number 携帯番号には(-)なしで11桁の数字を入力してください')
      end
    
    end
  end
end

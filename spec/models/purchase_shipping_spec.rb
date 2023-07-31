require 'rails_helper'

RSpec.describe PurchaseShipping, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @purchase_shipping = FactoryBot.build(:purchase_shipping, user_id: user.id, item_id: item.id)
    end  

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_shipping).to be_valid
      end

      it 'buildingは空でも保存できること' do
        @purchase_shipping.building = nil
        expect(@purchase_shipping).to be_valid
      end

      it 'priceとtokenがあれば保存ができること' do
        expect(@purchase_shipping).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'post_codeが空だと保存できないこと' do
        @purchase_shipping.post_code = nil
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Post code can't be blank")
      end
  
      it 'post_codeは、「3桁ハイフン4桁」の半角文字列のみでないと保存できないこと' do
        @purchase_shipping.post_code = '1234-567'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Post code is invalid")
      end
  
      it 'prefecture_idを選択していないと保存できないこと' do
        @purchase_shipping.prefecture_id = nil
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Prefecture can't be blank")
      end
  
      it 'cityが空だと保存できないこと' do
        @purchase_shipping.city = nil
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("City can't be blank")
      end
  
      it 'addressが空だと保存できないこと' do
        @purchase_shipping.address = nil
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Address can't be blank")
      end
  
      it 'telephone_numberが空だと保存できないこと' do
        @purchase_shipping.telephone_number = nil
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Telephone number can't be blank")
      end
  
      it 'telephone_numberは、10桁以上11桁以内の半角数値のみでないと保存できないこと' do
        @purchase_shipping.telephone_number = '090123456'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Telephone number is too short (minimum is 10 characters)")
      end

      it 'telephone_numberは、10桁以上11桁以内の半角数値のみでないと保存できないこと' do
        @purchase_shipping.telephone_number = '090123456789'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Telephone number is too long (maximum is 11 characters)")
      end

      it 'telephone_numberは、10桁以上11桁以内の半角数値のみでないと保存できないこと' do
        @purchase_shipping.telephone_number = '09012345678!'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Telephone number is not a number")
      end

      it 'tokenが空では登録できないこと' do
        @purchase_shipping.token = nil
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Token can't be blank")
      end

      it 'user_idが空だと保存できないこと' do
        @purchase_shipping.user_id = nil
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("User can't be blank")
      end
      
      it 'item_idが空だと保存できないこと' do
        @purchase_shipping.item_id = nil
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Item can't be blank")
      end
      

    end
  end
end

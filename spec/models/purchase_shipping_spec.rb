require 'rails_helper'

RSpec.describe PurchaseShipping, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      @purchase_shipping = FactoryBot.build(:purchase_shipping, user_id: user.id)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_shipping).to be_valid
      end

      it 'buildingは空でも保存できること' do
        @purchase_shipping.building = nil
        expect(@purchase_shipping).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'post_codeが空だと保存できないこと' do
        @purchase_shipping.post_code = nil
        expect(@purchase_shipping).not_to be_valid
      end

      it 'post_codeは、「3桁ハイフン4桁」の半角文字列のみでないと保存できないこと' do
        @purchase_shipping.post_code = '1234-567'
        expect(@purchase_shipping).not_to be_valid

        @purchase_shipping.post_code = '12-34567'
        expect(@purchase_shipping).not_to be_valid

        @purchase_shipping.post_code = '123-45678'
        expect(@purchase_shipping).not_to be_valid
      end

      it 'prefecture_idを選択していないと保存できないこと' do
        @purchase_shipping.prefecture_id = nil
        expect(@purchase_shipping).not_to be_valid
      end

      it 'cityが空だと保存できないこと' do
        @purchase_shipping.city = nil
        expect(@purchase_shipping).not_to be_valid
      end

      it 'addressが空だと保存できないこと' do
        @purchase_shipping.address = nil
        expect(@purchase_shipping).not_to be_valid
      end

      it 'telephone_numberが空だと保存できないこと' do
        @purchase_shipping.telephone_number = nil
        expect(@purchase_shipping).not_to be_valid
      end

      it 'telephone_numberは、10桁以上11桁以内の半角数値のみでないと保存できないこと' do
        @purchase_shipping.telephone_number = '090-1234-5678'
        expect(@purchase_shipping).not_to be_valid

        @purchase_shipping.telephone_number = '090123456789'
        expect(@purchase_shipping).not_to be_valid

        @purchase_shipping.telephone_number = '090-1234-567'
        expect(@purchase_shipping).not_to be_valid

        @purchase_shipping.telephone_number = '090-1234-56789'
        expect(@purchase_shipping).not_to be_valid
      end
    end
  end
end
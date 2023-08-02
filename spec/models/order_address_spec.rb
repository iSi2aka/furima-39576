require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user: @user, item: @item)
  end

  describe '商品購入機能' do

    context '商品購入できる場合' do
      it 'すべての項目が正しく入力できていれば購入できる' do
        expect(@order_address).to be_valid
      end
      it 'building_numは空でも購入できる' do
        @order_address.building_num = ''
        expect(@order_address).to be_valid
      end
    end

    context '商品購入できない場合' do
      it "postal_codeが空では購入できない" do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it "postal_codeにハイフン(―)がないと購入できない" do
        @order_address.postal_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it "postal_codeのハイフン(―)の位置が誤っていると購入できない" do
        @order_address.postal_code = '1234-567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it "prefecture_idが空では登録できない" do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it "cityが空では購入できない" do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it "street_numが空では購入できない" do
        @order_address.street_num = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Street num can't be blank")
      end
      it "phone_numが空では購入できない" do
        @order_address.phone_num = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone num can't be blank")
      end
      it "phone_numが9文字以下/12文字以上では購入できない" do
        phone_num = ['123456789', '123456789012']
        phone_num.each do |phone| 
          @order_address.phone_num = phone
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Phone num は（半角数字）10~11文字で入力する必要があります")
        end
      end
      it "phone_numが（半角数字）以外では購入できない" do
        phone_num = ['123-456-7890', '１２３４５６７']
        phone_num.each do |phone|
          @order_address.phone_num = phone
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Phone num は（半角数字）10~11文字で入力する必要があります")
        end
      end
      it "userが紐づいていない状態では購入できない" do
        @order_address.user = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it "itemが紐づいていない状態では購入できない" do
        @order_address.item = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
      it "tokenが空では購入できない" do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end 
    end
  end
end
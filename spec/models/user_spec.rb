require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録/ユーザー登録' do

    context '新規登録できる場合' do
      it 'すべての項目が正しく入力できていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do 
      it "nicknameが空では登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it "passwordが空では登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = 'test1'
        @user.password_confirmation = 'test1'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password =  Faker::Internet.password(min_length: 129, max_length: 150)
        @user.password_confirmation =  @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end
      it 'passwordは半角数字だけでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角英数を両方含む必要があります')
      end
      it 'passwordは半角英字だけでは登録できない' do
        @user.password = 'testtest'
        @user.password_confirmation = 'testtest'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角英数を両方含む必要があります')
      end
      it 'passwordは全角だけでは登録できない' do
        @user.password = 'あかさたなはまやらわ'
        @user.password_confirmation = 'あかさたなはまやらわ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角英数を両方含む必要があります')
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'test1234'
        @user.password_confirmation = 'test12345'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end   
      it 'お名前(全角)は、名字が空では登録できない' do
        @user.last_name_em = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name em can't be blank")
      end
      it 'お名前(全角)は、名前が空では登録できない' do
        @user.first_name_em = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name em can't be blank")
      end
      it 'お名前(全角)は、名字が半角では登録できない' do
        @user.last_name_em = 'Yamada' 
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name em は（全角）で入力する必要があります")
      end
      it 'お名前(全角)は、名前が半角では登録できない' do
        @user.first_name_em = 'Taro' 
        @user.valid?
        expect(@user.errors.full_messages).to include("First name em は（全角）で入力する必要があります")
      end
      it 'お名前カナ(全角)は、名字が空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'お名前カナ(全角)は、名前が空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'お名前カナ(全角)は、名字が（カタカナ）以外では登録できない' do
        last_kana = ['Yamada', '山田', 'やまだ']
        last_kana.each do |kana|
          @user.last_name_kana = kana
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name kana は（カタカナ）で入力する必要があります")
        end
      end
      it 'お名前カナ(全角)は、名前が（カタカナ）以外では登録できない' do
        first_kana = ['Taro', '太郎', 'たろう']
        first_kana.each do |kana|
          @user.first_name_kana = kana
          @user.valid?
          expect(@user.errors.full_messages).to include("First name kana は（カタカナ）で入力する必要があります")
        end 
      end
      it '生年月日が必須であること' do
        @user.birth_day = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth day can't be blank")
      end
    end 
  end 
end

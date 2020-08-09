require 'rails_helper'
describe User do
  describe '#create' do
    
    it "全項目が入力されていれば登録できる" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "ニックネームが空の場合登録ができない" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    it "メールアドレスは重複して登録できない" do
      user = create(:user)
      #先に登録したユーザーと同じemailの値を持つユーザーのインスタンスを作成
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

    it "メールアドレスが@を含まないと登録できない" do
      user = build(:user, email: "kkkgmail.com")
      user.valid?
      expect(user.errors[:email]).to include("is invalid")
    end

    it "メールアドレスの@の後ろに文字を含まないと登録できない" do
      user = build(:user, email: "kkk@")
      user.valid?
      expect(user.errors[:email]).to include("is invalid")
    end

    it "パスワードが空の場合登録ができない" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "パスワードは7文字以上なら登録できる" do
      user = build(:user, password: "1234567", password_confirmation: "1234567")
      expect(user).to be_valid
    end

    it "パスワードは6文字以下なら登録できない" do
      user = build(:user, password: "12345", password_confirmation: "12345")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

    it "パスワードは確認用と含めて2回入力しないと登録できない" do
      user = build(:user, password_confirmation: nil)
      user.valid?
      expect(user.errors[:password_confirmation]).to include("can't be blank")
    end

    it "ユーザーの苗字が空だと登録できない" do
      user = build(:user, family_name: nil)
      user.valid?
      expect(user.errors[:family_name]).to include("can't be blank")
    end

    it "ユーザーの名前が空だと登録できない" do
      user = build(:user, first_name: nil)
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    it "ユーザーの苗字の振り仮名が空だと登録できない" do
      user = build(:user, family_name_kana: nil)
      user.valid?
      expect(user.errors[:family_name_kana]).to include("can't be blank")
    end

    it "ユーザーの名前の振り仮名が空だと登録できない" do
      user = build(:user, first_name_kana: nil)
      user.valid?
      expect(user.errors[:first_name_kana]).to include("can't be blank")
    end

    it "ユーザーの誕生日が空だと登録できない" do
      user = build(:user, birth_day: nil)
      user.valid?
      expect(user.errors[:birth_day]).to include("can't be blank")
    end

  end
end
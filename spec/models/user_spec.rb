require 'rails_helper'

describe User do
  describe '#create' do

    # 1.全ての必須カラムが入力されているときにDBに保存する
    it "is valid with all" do
      user = build(:user)
      expect(user).to be_valid
    end

    # 2.Eメールが入力されていない時にDBに保存しない
    it "is invalid without a email" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    # 3. 重複したemailが存在する場合登録できないこと
    it "is invalid with a duplicate email address" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

    # 4.パスワードが入力されていない時にDBに保存しない
    it "is invalid without a password" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    # 5. passwordが7文字以上であれば登録できること
    it "is valid with a password that has more than 6 characters " do
      user = build(:user, password: "000000")
      user.valid?
      expect(user).to be_valid
    end

    # 6. passwordが6文字以下であれば登録できないこと
    it "is invalid with a password that has less than 5 characters " do
      user = build(:user, password: "00000")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

    # 7.ニックネームが入力されていない時にDBに保存しない
    it "is invalid without a nickname" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    # 8.名前（名）が入力されていない時にDBに保存しない
    it "is invalid without a last_name" do
      user = build(:user, last_name: nil)
      user.valid?
      expect(user.errors[:last_name]).to include("can't be blank")
    end

    # 9.名前（姓）が入力されていない時にDBに保存しない
    it "is invalid without a first_name" do
      user = build(:user, first_name: nil)
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    # 10.カナ（名）が入力されていない時にDBに保存しない
    it "is invalid without a last_name_kana" do
      user = build(:user, last_name_kana: nil)
      user.valid?
      expect(user.errors[:last_name_kana]).to include("can't be blank")
    end

    # 11.カナ（姓）が入力されていない時にDBに保存しない
    it "is invalid without a first_name_kana" do
      user = build(:user, first_name_kana: nil)
      user.valid?
      expect(user.errors[:first_name_kana]).to include("can't be blank")
    end

    # 12.生年月日（年）が入力されていない時にDBに保存しない
    it "is invalid without a birthday_year" do
      user = build(:user, birthday_year: nil)
      user.valid?
      expect(user.errors[:birthday_year]).to include("can't be blank")
    end

    # 13.生年月日（月）が入力されていない時にDBに保存しない
    it "is invalid without a birthday_month" do
      user = build(:user, birthday_month: nil)
      user.valid?
      expect(user.errors[:birthday_month]).to include("can't be blank")
    end

    # 14.生年月日（日）が入力されていない時にDBに保存しない
    it "is invalid without a birthday_day" do
      user = build(:user, birthday_day: nil)
      user.valid?
      expect(user.errors[:birthday_day]).to include("can't be blank")
    end

    # 15.電話番号が入力されていない時にDBに保存しない
    it "is invalid without a phone_number" do
      user = build(:user, phone_number: nil)
      user.valid?
      expect(user.errors[:phone_number]).to include("can't be blank")
    end

    # 16.郵便番号の入力が数字ではない時にDBに保存しない
    it "is invalid without a post_code" do
      user = build(:user, post_code: "アイウエオ")
      user.valid?
      expect(user.errors[:post_code]).to include("is not a number")
    end


    # 17.住所の名前（名）が入力されていない時にDBに保存しない
    it "is invalid without a address_last_name" do
      user = build(:user, address_last_name: nil)
      user.valid?
      expect(user.errors[:address_last_name]).to include("can't be blank")
    end

    # 18.住所の名前（姓）が入力されていない時にDBに保存しない
    it "is invalid without a address_first_name" do
      user = build(:user, address_first_name: nil)
      user.valid?
      expect(user.errors[:address_first_name]).to include("can't be blank")
    end

    # 19.住所のカナ（名）が入力されていない時にDBに保存しない
    it "is invalid without a address_last_name_kana" do
      user = build(:user, address_last_name_kana: nil)
      user.valid?
      expect(user.errors[:address_last_name_kana]).to include("can't be blank")
    end

    # 20.住所のカナ（姓）が入力されていない時にDBに保存しない
    it "is invalid without a address_first_name_kana" do
      user = build(:user, address_first_name_kana: nil)
      user.valid?
      expect(user.errors[:address_first_name_kana]).to include("can't be blank")
    end

    # 21.住所（都道府県）が入力されていない時にDBに保存しない
    it "is invalid without a address_prefecture" do
      user = build(:user, address_prefecture: nil)
      user.valid?
      expect(user.errors[:address_prefecture]).to include("can't be blank")
    end

    # 22.住所（市区町村）が入力されていない時にDBに保存しない
    it "is invalid without a address_city" do
      user = build(:user, address_city: nil)
      user.valid?
      expect(user.errors[:address_city]).to include("can't be blank")
    end

    # 23.住所（番地）が入力されていない時にDBに保存しない
    it "is invalid without a address_number" do
      user = build(:user, address_number: nil)
      user.valid?
      expect(user.errors[:address_number]).to include("can't be blank")
    end

  end
end
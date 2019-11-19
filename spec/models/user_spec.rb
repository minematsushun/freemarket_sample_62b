require 'rails_helper'

describe User do
  describe '#create' do

    # 1.Eメールとパスワードが入力されているときにDBに保存する
    it "is valid with a email, password" do
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

  end
end
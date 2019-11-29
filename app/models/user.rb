class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #omniauthableを追加して拡張
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable,
        :omniauthable, omniauth_providers: %i[facebook google_oauth2]
  has_many :cards
  has_many :items
  has_many :sns_credentials, dependent: :destroy
  # has_many :buyed_items, foreign_key: "buyer_id", class_name: "Item"
  # has_many :saling_items, -> { where("buyer_id is NULL") }, foreign_key: "saler_id", class_name: "Item"
  # has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: "saler_id", class_name: "Item"

  def self.without_sns_data(auth)
    user = User.where(email: auth.info.email).first

    if user.present?
      sns = SnsCredential.create(
        uid: auth.uid,
        provider: auth.provider,
        user_id: user.id
      )
    else
      user = User.new(
        nickname: auth.info.name,
        email: auth.info.email,
      )
      sns = SnsCredential.new(
        uid: auth.uid,
        provider: auth.provider
      )
    end
    return { user: user, sns: sns}
  end

  def self.with_sns_data(auth, snscredential)
    user = User.where(id: snscredential.user_id).first
    unless user.present?
      user = User.new(
        email: auth.info.email
      )
    end
    return {user: user}
  end

  # findメソッド実装 omniauthのコールバックで呼ばれるメソッド
  def self.find_for_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.where(uid: uid, provider: provider).first
    if snscredential.present?
      user = with_sns_data(auth, snscredential)[:user]
      sns = snscredential
    else
      user = without_sns_data(auth)[:user]
      sns = without_sns_data(auth)[:sns]
    end
    return { user: user, sns: sns}
  end

  # バリデーション
  VALID_EMAIL_REGEX =                 /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  #step1
  validates :nickname,                presence: true, length: {maximum: 20}, on: :validates_step1
  validates :email,                   presence: true, uniqueness: true, format: {with: VALID_EMAIL_REGEX}, on: :validates_step1
  validates :password,                presence: true, length: {minimum: 6, maximum: 128}, on: :validates_step1
  validates :last_name,               presence: true, on: :validates_step1
  validates :first_name,              presence: true, on: :validates_step1
  validates :last_name_kana,          presence: true, on: :validates_step1
  validates :first_name_kana,         presence: true, on: :validates_step1
  validates :birthday_year,           presence: true, on: :validates_step1
  validates :birthday_month,          presence: true, on: :validates_step1
  validates :birthday_day,            presence: true, on: :validates_step1

  #STEP2
  validates :phone_number,            presence: true, on: :validates_step2

  #STEP3
  validates :address_last_name,       presence: true, on: :validates_step3
  validates :address_first_name,      presence: true, on: :validates_step3
  validates :address_last_name_kana,  presence: true, on: :validates_step3
  validates :address_first_name_kana, presence: true, on: :validates_step3
  validates :post_code,               presence: true, numericality: true, on: :validates_step3
  validates :address_prefecture,      presence: true, on: :validates_step3
  validates :address_city,      presence: true, on: :validates_step3
  validates :address_number,      presence: true, on: :validates_step3

end
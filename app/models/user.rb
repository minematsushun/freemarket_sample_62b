class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #omniauthableを追加して拡張
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable,
        :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  # findメソッド実装 omniauthのコールバックで呼ばれるメソッド
  def self.find_for_oauth(auth)
    where(uid: auth.uid, provider: auth.provider).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
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
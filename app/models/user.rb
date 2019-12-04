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
  has_many :seller_items, class_name: 'Item', foreign_key: 'seller_id'
  has_many :buyer_items, class_name: 'Item', foreign_key: 'buyer_id'


  # findメソッド実装 omniauthのコールバックで呼ばれるメソッド
  def self.find_for_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.where(uid: uid, provider: provider).first #firstをつけないとデータが配列で返されて使いたいメソッドが使えなくて困る

    #sns_credentialsが登録されている
    if snscredential.present?
      user = User.where(email: auth.info.email).first

      # userが登録されていない
      unless user.present?
        user = User.new(
          email: auth.info.email,
          nickname: auth.info.name
          )
      end

        sns = snscredential
        #返り値をハッシュにして扱いやすくする
        #活用例 info = User.find_oauth(auth)
        #session[:nickname] = info[:user][:nickname]
        { user: user, sns: sns }

        #sns_credentialsが登録されていない
    else
      user = User.where(email: auth.info.email).first

      #userが登録されている場合
      if user.present?
        sns = SnsCredential.create(
          uid: uid,
          provider: provider,
          user_id: user.id
        )

        { user: user, sns: sns}

      #userが登録されていない場合
      else
        user = User.new(
          email: auth.info.email,
          nickname: auth.info.name
        )
        sns = SnsCredential.new(
          provider: auth.provider,
          uid: auth.uid
        )

        {user: user, sns: sns}
      end
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
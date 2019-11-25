class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #omniauthableを追加して拡張
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable,
        :omniauthable, omniauth_providers: %i[facebook google_oauth2]
        has_many :cards

        has_many :items

  # findメソッド実装 omniauthのコールバックで呼ばれるメソッド
  def self.find_for_oauth(auth)
    where(uid: auth.uid, provider: auth.provider).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end
end

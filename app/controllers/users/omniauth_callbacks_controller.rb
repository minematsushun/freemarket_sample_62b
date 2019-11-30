class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback_from(:facebook)
  end

  def google_oauth2
    callback_from(:google)
  end

  # common callback method
  def callback_from(provider)
    provider = provider.to_s
    info = User.find_for_oauth(request.env['omniauth.auth'])
    # snsの情報userが登録されているか or snsから情報を取得できているかを確認
    @user = User.where(nickname: info[:user][:nickname]).or(User.where(email: info[:user][:email])).first || info[:user]

    # persisted?はデータがDBに保存されているかを確認する/配列に対しては使えないから@userを定義するときは気をつける
    if @user.persisted?
      #保存されていればログインしてroot_pathにリダイレクトされる
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
      sign_in_and_redirect @user, event: :authentication
    else
      # 登録するアクションに取得した値を渡すために。sessionを利用してuserインスタンスを作成する
      session[:nickname] = info[:user][:nickname]
      session[:email] = info[:user][:email]

      #snsでのユーザ登録ではパスワードを入力させないので準備する。パスワードを作成するDeviseメソッドもある。
      #今回のバリデーションは英数字のみなのでこっちを採用
      session[:password_confirmation] = SecureRandom.alphanumeric(30)

      #SnsCredentialが登録されていないとき
      if SnsCredential.find_by(uid: info[:sns][:uid], provider: info[:sns][:provider]).nil?
        #ユーザ登録と同時にsns_credentialも登録するために
        session[:uid] = info[:sns][:uid]
        session[:provider] = info[:sns][:provider]
      end
      #登録フォームにリダイレクト
      redirect_to step1_signup_index_path
    end
  end

  def failure
    redirect_to root_path
  end
end

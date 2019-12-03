class SignupController < ApplicationController
  before_action :root
  before_action :validates_step1, only: :step2 #step1のバリデーション
  before_action :validates_step2, only: :step3 #step2のバリデーション
  before_action :validates_step3, only: :step4 #step3のバリデーション

  def index
  end

  ##omniauth_callbacks_controllerからリダイレクトされたアクション
  def step1
    if session[:password_confirmation]
      #sns認証を使った場合は情報利用してインスタンスを作成.
      #viewで条件分岐などを利用してパスワードフォームを表示させない
      @user = User.new(
        #omniauth_callbacks_controllerで定義したsession
        nickname: session[:nickname],
        email: session[:email],
        password: session[:password_confirmation]
      )
    else
      @user = User.new
    end
  end

  def step2
    @user = User.new
  end

  def step3
    @user = User.new
  end

  def step4
    @user = User.new
  end

  def create
    @user = User.new(
      nickname: session[:nickname], #sessionに保存された値を返す
      email: session[:email],
      password: session[:password],
      last_name: session[:last_name],
      first_name: session[:first_name],
      last_name_kana: session[:last_name_kana],
      first_name_kana: session[:first_name_kana],
      birthday_year: session[:birthday_year],
      birthday_month: session[:birthday_month],
      birthday_day: session[:birthday_day],
      phone_number: session[:phone_number],
      address_last_name: session[:address_last_name],
      address_first_name: session[:address_first_name],
      address_last_name_kana: session[:address_last_name_kana],
      address_first_name_kana: session[:address_first_name_kana],
      post_code: session[:post_code],
      address_prefecture: session[:address_prefecture],
      address_city: session[:address_city],
      address_number: session[:address_number],
      address_building: session[:address_building],
      address_phone_number: session[:address_phone_number]
    )
    if @user.save
      #ログインするための情報
      session[:id] = @user.id
      SnsCredential.create(  #ユーザ登録と同時にこっちも登録
        uid: session[:uid],
        provider: session[:provider],
        user_id: @user.id
      )
      redirect_to done_signup_index_path
    else
      render '/signup/index'
    end
  end

  def done
    sign_in User.find(session[:id]) unless user_signed_in?
    redirect_to root_path
  end

  #バリデーションのチェック
  def validates_step1
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:last_name] = user_params[:last_name]
    session[:first_name] = user_params[:first_name]
    session[:last_name_kana] = user_params[:last_name_kana]
    session[:first_name_kana] = user_params[:first_name_kana]
    session[:birthday_year] = params[:birthday][:"birthday(1i)"]
    session[:birthday_month] = params[:birthday][:"birthday(2i)"]
    session[:birthday_day] = params[:birthday][:"birthday(3i)"]
    #バリデーション用に、仮でインスタンスを作成
    @user = User.new(
      nickname: session[:nickname], #sessionに保存された値を返す
      email: session[:email],
      password: session[:password],
      last_name: session[:last_name],
      first_name: session[:first_name],
      last_name_kana: session[:last_name_kana],
      first_name_kana: session[:first_name_kana],
      birthday_year: session[:birthday_year],
      birthday_month: session[:birthday_month],
      birthday_day: session[:birthday_day]
      )
    render '/signup/step1' unless @user.valid?(:validates_step1)
  end

  def validates_step2
    session[:phone_number] = user_params[:phone_number]
    #バリデーション用に、仮でインスタンスを作成
    @user = User.new(
      email: session[:email],
      password: session[:password],
      phone_number: session[:phone_number]
      )
    render '/signup/step2' unless @user.valid?(:validates_step2)
  end

  def validates_step3
    session[:address_last_name] = user_params[:address_last_name]
    session[:address_first_name] = user_params[:address_first_name]
    session[:address_last_name_kana] = user_params[:address_last_name_kana]
    session[:address_first_name_kana] = user_params[:address_first_name_kana]
    session[:post_code] = user_params[:post_code]
    session[:address_prefecture] = user_params[:address_prefecture]
    session[:address_city] = user_params[:address_city]
    session[:address_number] = user_params[:address_number]
    session[:address_building] = user_params[:address_building]
    session[:address_phone_number] = user_params[:address_phone_number]
    #バリデーション用に、仮でインスタンスを作成
    @user = User.new(
      email: session[:email],
      password: session[:password],
      address_last_name: session[:address_last_name],
      address_first_name: session[:address_first_name],
      address_last_name_kana: session[:address_last_name_kana],
      address_first_name_kana: session[:address_first_name_kana],
      post_code: session[:post_code],
      address_prefecture: session[:address_prefecture],
      address_city: session[:address_city],
      address_number: session[:address_number],
      address_building: session[:address_building],
      address_phone_number: session[:address_phone_number]
    )
    render '/signup/step3' unless @user.valid?(:validates_step3)
  end

  private

  def root
    redirect_to root_path if user_signed_in?
  end

  def user_params
    params.require(:user).permit(
      :nickname,
      :email,
      :password,
      :last_name,
      :first_name,
      :last_name_kana,
      :first_name_kana,
      :birthday_year,
      :birthday_month,
      :birthday_day,
      :phone_number,
      :address_last_name,
      :address_first_name,
      :address_last_name_kana,
      :address_first_name_kana,
      :post_code,
      :address_prefecture,
      :address_city,
      :address_number,
      :address_building,
      :address_phone_number
    )
  end
end

class SignupController < ApplicationController
  def index
  end

  def step1
    @user = User.new
  end

  def step2
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:last_name] = user_params[:last_name]
    session[:first_name] = user_params[:first_name]
    session[:last_name_kana] = user_params[:last_name_kana]
    session[:first_name_kana] = user_params[:first_name_kana]
    session[:birthday_year] = user_params[:birthday_year]
    session[:birthday_year] = user_params[:birthday_year]
    session[:birthday_month] = user_params[:birthday_month]
    session[:birthday_month] = user_params[:birthday_month]
    session[:birthday_day] = user_params[:birthday_day]
    @user = User.new
  end

  def step3
    session[:phone_number] = user_params[:phone_number]
    @user = User.new
  end

  def step4
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
    @user = User.new
  end

  def create
    @user = User.new(
      nickname: session[:nickname], #sessionに保存された値を返す
      email: session[:email],
      password: session[:password],
      last_name: session[:last_name],
      last_name: session[:last_name],
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
      redirect_to done_signup_index_path
    else
      render '/signup/registrantion'
    end
  end


  def done
    sign_in User.find(session[:id]) unless user_signed_in?
    end
  end

  private
  def user_params
    params.require(:users).permit(
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

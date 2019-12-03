class UsersController < ApplicationController
  before_action :confirmation

  def myPage  #マイページ
  end

  def myProfile #マイプロフィール
    @user = User.find(params[:id])
  end

  def identification #本人確認
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(params_profile)
    redirect_to myPage_users_path
  end

  def logout
  end

  private

  def confirmation  #ログインしていない場合ははユーザー登録に移動
    unless user_signed_in?
      redirect_to(user_session_path)
    end
  end

  def params_profile
    params.require(:user).permit(
      :nickname,
      :email,
      :password,
      :address_last_name,
      :address_first_name,
      :address_last_name_kana,
      :address_first_name_kana,
      :post_code,
      :address_prefecture,
      :address_city,
      :address_number,
      :address_building,
      :address_phone_number,
      :introduce)
  end

end

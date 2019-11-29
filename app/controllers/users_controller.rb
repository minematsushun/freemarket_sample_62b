class UsersController < ApplicationController
  before_action :confirmation
  
  def myPage  #マイページ
  end

  def myProfile #マイプロフィール
  end

  def identification #本人確認
  end

  def logout
  end

  def confirmation  #ログインしていない場合ははユーザー登録に移動
    unless user_signed_in?
      redirect_to(user_session_path)
    end
  end

end

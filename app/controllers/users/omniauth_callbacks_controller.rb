class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback_from(:facebook)
  end

  def google_oauth2
    callback_from(:google)
  end

  private

  def callback_from(provider)
    provider = provider.to_s

    info = User.find_for_oauth(request.env['omniauth.auth'])
    @user = info[:user]
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    else
      @sns = info[:sns]
      redirect_to step1_signup_index_path
    end
  end

  def failure
    redirect_to root_path
  end
end

Rails.application.routes.draw do
  devise_for :users, skip: [:sessions] #sessionをスキップしてas :user で定義する。
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "items#index"
  resources :items, only: :index

  #デバイスのデフォルトリンクを変更
  as :user do
    get 'signin', to: 'devise/sessions#new', as: :new_user_session
    post 'signin', to: 'devise/sessions#create', as: :user_session
    delete 'signout', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  get "signup" => "signup#index"
  get "items/sell" => "items#sell"
  get "items/exhibit" => "items#exhibit"
  get "items/myProfile" => "items#myProfile"
  get "items/cardRegister" => "items#cardRegister"
  get "items/howToPay" => "items#howToPay"
  get "items/newUserRegistration" => "items#newUserRegistration"
  get "items/userLogin" => "items#userLogin"
  get "items/userEdit" => "items#userEdit"
  get "items/userTelConfirmation" => "items#userTelConfirmation"
  get "items/userTelAuthentication" => "items#userTelAuthentication"
  get "items/userHowToPay" => "items#userHowToPay"
  get "items/userAddress" => "items#userAddress"
  get "items/userLogout" => "items#userLogout"
  get "items/userCompRegistration" => "items#userCompRegistration"
  get "items/myPage" => "items#myPage"
  get "items/checkYourself" => "items#checkYourself"
  get "items/info" => "items#info"
end

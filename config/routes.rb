Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}, skip: [:sessions]
  #sessionをスキップしてas :user で定義する。

  root to: "items#index"

  #デバイスのデフォルトリンクを変更
  as :user do
    get 'signin', to: 'devise/sessions#new', as: :new_user_session
    post 'signin', to: 'devise/sessions#create', as: :user_session
    delete 'signout', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  #ユーザー新規登録
  resources :signup do
    collection do
      get "step1"
      get "step2"
      get "step3"
      get "step4"
      get "done"
    end
  end

  #mypage関連
  resources :users do
    collection do
      get 'myPage'
      get 'myProfile'
      get 'identification'
      get 'logout'
    end
  end

  #カード新規登録
  get 'purchase/index'
  get 'purchase/done'
  get 'card/new'
  get 'card/show'

  resources :card, only: [:new, :show] do
    collection do
      post 'show', to: 'card#show'
      post 'pay', to: 'card#pay'
      post 'delete', to: 'card#delete'
    end
  end
  resources :purchase, only: [:index] do
    collection do
      get 'show', tp: 'purchase#show'
      get 'index', to: 'purchase#index'
      post 'pay', to: 'purchase#pay'
      get 'done', to: 'purchase#done'
    end
  end


  get "green/sell" => "green#sell"
  get "green/exhibit" => "green#exhibit"
  get "green/cardRegister" => "green#cardRegister"
  get "green/howToPay" => "green#howToPay"
  get "green/newUserRegistration" => "green#newUserRegistration"
  get "green/userLogin" => "green#userLogin"
  get "green/userEdit" => "green#userEdit"
  get "green/userTelConfirmation" => "green#userTelConfirmation"
  get "green/userTelAuthentication" => "green#userTelAuthentication"
  get "green/userHowToPay" => "green#userHowToPay"
  get "green/userAddress" => "green#userAddress"
  get "green/userCompRegistration" => "green#userCompRegistration"
  get "green/info" => "green#info"
  get "green/pay" => "green#pay"


  resources :items do
    collection do
      get "category_children", defaults: { format: 'json' }
      get "category_grandchildren", defaults: { format: 'json' }
      get "delivery_children", defaults: { format: 'json' }
    end

end

end
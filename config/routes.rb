Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}, skip: [:sessions]
  #sessionをスキップしてas :user で定義する。

  root to: "green#index"
  # resources :items
  # 上のコメントアウトは一旦、そのままでお願いします

  #デバイスのデフォルトリンクを変更
  as :user do
    get 'signin', to: 'devise/sessions#new', as: :new_user_session
    post 'signin', to: 'devise/sessions#create', as: :user_session
    delete 'signout', to: 'devise/sessions#destroy', as: :destroy_user_session
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
      get 'index', to: 'purchase#index'
      post 'pay', to: 'purchase#pay'
      get 'done', to: 'purchase#done'
    end
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

  get "green/sell" => "green#sell"
  get "green/exhibit" => "green#exhibit"
  get "green/myProfile" => "green#myProfile"
  get "green/cardRegister" => "green#cardRegister"
  get "green/howToPay" => "green#howToPay"
  get "green/newUserRegistration" => "green#newUserRegistration"
  get "green/userLogin" => "green#userLogin"
  get "green/userEdit" => "green#userEdit"
  get "green/userTelConfirmation" => "green#userTelConfirmation"
  get "green/userTelAuthentication" => "green#userTelAuthentication"
  get "green/userHowToPay" => "green#userHowToPay"
  get "green/userAddress" => "green#userAddress"
  get "green/userLogout" => "green#userLogout"
  get "green/userCompRegistration" => "green#userCompRegistration"
  get "green/myPage" => "green#myPage"
  get "green/checkYourself" => "green#checkYourself"
  get "green/info" => "green#info"
  get "green/pay" => "green#pay"
 
  get "items/new" => "items#new"
  post "items" => "items#create"

  resources :items do
  collection do
  get "category_children", defaults: { format: 'json' }
  get "category_grandchildren", defaults: { format: 'json' }
  get "delivery_children", defaults: { format: 'json' }
  end

  get "/miyamoto" => "items#miyamoto"
end

end
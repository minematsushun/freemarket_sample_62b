Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "items#index"
  resources :items ,only: :index
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

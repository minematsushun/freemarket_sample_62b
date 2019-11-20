Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "green#index"
  resources :items ,only: :index
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


  get "items/new" => "items#new"
  post "items" => "items#create"
  get "category_children", defaults: {format: "json"}
  get "category_grandchildren", defaults: {format: "json"}
end
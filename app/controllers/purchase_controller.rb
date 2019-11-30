class PurchaseController < ApplicationController

  require 'payjp'

  


  def index
    @item = Item.find(params[:format])
    @card = Card.find_by(user_id: current_user.id)
    @user = User.find(id= current_user.id)
    @address = Prefecture.find(@user[:address_prefecture])
    if @card.blank?

    else

    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"] 

    customer = Payjp::Customer.retrieve(@card.customer_id)

    @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

#   def pay
#     @card = Card.find_by(user_id: current_user.id)
#     @item = Item.find(params[:format])
#     @user = User.find(id= current_user.id)

#     if @card.blank?
#     redirect_to controller: "card", action: "new"
#     else

#     Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
#     Payjp::Charge.create(
#     :amount   => @item.price, 
#     :customer => @card.customer_id, 
#     :currency => 'jpy', 
#   )
#   redirect_to action: 'done'
#    end
#  end

def done
  @card = Card.find_by(user_id: current_user.id)
  @item = Item.find(params[:format])
  @user = User.find(id= current_user.id)
  @address = Prefecture.find(@user[:address_prefecture])
  if @card.blank?
  redirect_to controller: "card", action: "new"

  else
  Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
  Payjp::Charge.create(
  :amount   => @item.price, 
  :customer => @card.customer_id, 
  :currency => 'jpy', 
)
    end
  end
end

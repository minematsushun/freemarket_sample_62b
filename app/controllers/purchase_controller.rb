class PurchaseController < ApplicationController

  require 'payjp'
  before_action :set_card,only: [:index, :pay]
  
  def set_card
    @card = Card.find_by(user_id: current_user.id)
  end

  def index
    @item=Item.find_by(params[:id])
    @card = Card.find_by(user_id: current_user.id)
    @user = User.find(id= current_user.id)
    @address = @user.address_city
    @addresss = @user.address_number
    @address2 = @user.address_building
    
      
    if @card.blank?

    else

      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"] 

      customer = Payjp::Customer.retrieve(@card.customer_id)

      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  
  
  
  def pay
    @card = Card.find_by(user_id: current_user.id)
    @item=Item.find_by(params[:id])
    @user = User.find(id= current_user.id)

    if @card.blank?
    redirect_to controller: "card", action: "new"

    else
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
    :amount   => @item.price, 
    :customer => @card.customer_id, 
    :currency => 'jpy', 
  )
  redirect_to action: 'done'
   end
 end

  def done
    @card = current_user.cards.first
    @item=Item.find_by(params[:id])
    @user = User.find(id= current_user.id)
    @address = @user.address_city
    @addresss = @user.address_number
    @address2 = @user.address_building
    redirect_to controller: "card", action: "new" if @card.blank?
   end

   def show
   end

 end

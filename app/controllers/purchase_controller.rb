class PurchaseController < ApplicationController

  require 'payjp'

  def index
    card = Card.find_by(user_id: current_user.id)

    if card.blank?

      redirect_to controller: "card", action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]

      customer = Payjp::Customer.retrieve(card.customer_id)

      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def pay
    card = Card.find_by(user_id: current_user.id)
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
    :amount => 10000, 
    :customer => card.customer_id, 
    :currency => 'jpy', 
  )
  redirect_to action: 'done'
  end

end
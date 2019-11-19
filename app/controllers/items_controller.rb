class ItemsController < ApplicationController

  def new
  end

  def create
    Item.create(product_name: params[:product_name], product_text: params[:product_text], price: params[:price])
  end

end

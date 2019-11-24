class ItemsController < ApplicationController
  def index
    @items = Item.all.order("RAND()").limit(10)
  end
end
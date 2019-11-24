class ItemsController < ApplicationController
  def show
    @items = Item.find(4)
  end
end

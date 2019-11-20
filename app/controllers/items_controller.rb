class ItemsController < ApplicationController

  def new
    @item = Item.new
    @parents = Category.all.order("id ASC").limit(13)
  end

  def create
    Item.create(item_params)
  end

  private
    def item_params
      params.require(:item).permit(:product_name, :product_text, :price)
end

end
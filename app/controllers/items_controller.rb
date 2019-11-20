class ItemsController < ApplicationController

  def new
    @item = Item.new
    @parents = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @parents << parent.name
    end
  end

  def category_children
    @children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def category_grandchildren
    @grandchildren = Category.find("#{params[:child_id]}").children
  end

  def create
    Item.create(item_params)
  end

  private
    def item_params
      params.require(:item).permit(:product_name, :product_text, :price)
end

end
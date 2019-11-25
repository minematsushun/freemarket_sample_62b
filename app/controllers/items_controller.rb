class ItemsController < ApplicationController

  def index
    @items = Item.order("RAND()").limit(10)
    @parent = Category.order("RAND()").limit(4)
  end

  def show
    @items = Item.find(1)
  end

  def new
    @item = Item.new
    @category = []
    Category.where(ancestry: nil).each do |parent|
    @category << parent
    end
  end

  def category_children
    @category_children = Category.find_by(params[:name]).children
  end

  def category_grandchildren
    @category_grandchildren = Category.find(params[:child_id]).children
  end

  def create
    Item.create(item_params)
  end

  private
    def item_params
      params.require(:item).permit(:product_name, :product_text, :price)


end

end
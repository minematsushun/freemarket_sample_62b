class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update] 

  def index
    
    @ladies = Item.where(category_id:1..199).order("created_at DESC").limit(10)
    @mens = Item.where(category_id:200..345).order("created_at DESC").limit(10)
    # @book = Item.where(category_id:625..684).order("created_at DESC").limit(10)
    # @homeappliance = Item.where(category_id:685..797).order("created_at DESC").limit(10)
  end

  def show
    @item = Item.find(params[:id])
    @box = Item.order("RAND()").limit(6)
    @user = User.find_by(params[:nickname])
    @grandchild = Category.find(@item[:category_id])
    @child = @grandchild.parent
    @parent = @child.parent
    @bland = Bland.find(@item[:bland_id])
    @delivery = Delivery.find(@item[:delivery_id])
    @charge = @delivery.parent
  end

  def edit
    
    @grandchild = Category.find(@item[:category_id])
    @child = @grandchild.parent
    @parent = @child.parent
    @bland = Bland.find(@item[:bland_id])
    @delivery = Delivery.find(@item[:delivery_id])
    @charge = @delivery.parent
    
    @selected_grandchild_category = @item.category
    @category_grandchildren_array = [{id: "---", name: "---"}]
    Category.find("#{@selected_grandchild_category.id}").siblings.each do |grandchild|
      grandchildren_hash = {id: "#{grandchild.id}", name: "#{grandchild.name}"}
      @category_grandchildren_array << grandchildren_hash
    end
    @selected_child_category = @selected_grandchild_category.parent
    @category_children_array = [{id: "---", name: "---"}]
    Category.find("#{@selected_child_category.id}").siblings.each do |child|
      children_hash = {id: "#{child.id}", name: "#{child.name}"}
      @category_children_array << children_hash
    end
    @selected_parent_category = @selected_child_category.parent
    @category_parents_array = [{id: "---", name: "---"}]
    Category.find("#{@selected_parent_category.id}").siblings.each do |parent|
      parent_hash = {id: "#{parent.id}", name: "#{parent.name}"}
      @category_parents_array << parent_hash
    end

    @selected_child_delivery = @item.delivery
    @delivery_children_array = [{id: "---", name: "---"}]
    Delivery.find("#{@selected_child_delivery.id}").siblings.each do |child|
      children_hash = {id: "#{child.id}", name: "#{child.name}"}
      @delivery_children_array << children_hash
    end
    @selected_parent_delivery = @selected_child_delivery.parent
    @delivery_parents_array = [{id: "---", name: "---"}]
    Delivery.find("#{@selected_parent_delivery.id}").siblings.each do |parent|
      parent_hash = {id: "#{parent.id}", name: "#{parent.name}"}
      @delivery_parents_array << parent_hash
    end

    @bland = Bland.pluck(:name)
  end

  def update
    if @item.update(item_params)
      redirect_to(items_path)
    else
      redirect_to action: :edit, notice: "全項目入力できていません"
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to(root_path)
  end

  def new
    @item = Item.new
    @category = []
    Category.where(ancestry: nil).each do |parent|
    @category << parent
    end

    @delivery = []
    Delivery.where(ancestry: nil).each do |parent_delivery|
    @delivery << parent_delivery
    end

    @bland = []
    Bland.where(params[:name]).each do |bland|
    @bland << bland
    end
  end

  def category_children
    children = Category.find(params[:name]).name
    @category_children = Category.find_by(name: children, ancestry: nil ).children
  end

  def category_grandchildren
    @category_grandchildren = Category.find(params[:child_id]).children
  end

  def delivery_children
    delivery = Delivery.find(params[:name]).name
    @delivery_children = Delivery.find_by(name: delivery, ancestry: nil).children
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '出品完了しました！'
    else
      render :new
    end
  end

  private
    def item_params
      params.require(:item).permit(:product_name,
                                  :product_text,
                                  :price, :image, 
                                  :category_id,
                                  :bland_id, 
                                  :size, 
                                  :delivery_id, 
                                  :shipping_region, 
                                  :shipping_date, 
                                  :commodity_condition, 
                                  :seller_id, 
                                  :buyer_id).merge(user_id_id: current_user.id, seller_id: 1, buyer_id: 1 )
    end

end
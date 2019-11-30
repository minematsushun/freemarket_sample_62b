class ItemsController < ApplicationController

  before_action :set_item, only: [:edit, :update] 
  before_action :confirmation, only: [:new]

  # 商品一覧表示
  def index
    @ladies = Item.where(category_id:1..199).order("created_at DESC").limit(10)
    @mens = Item.where(category_id:200..345).order("created_at DESC").limit(10)
    # @book = Item.where(category_id:625..684).order("created_at DESC").limit(10)
    # @homeappliance = Item.where(category_id:685..797).order("created_at DESC").limit(10)
  end

  # 商品詳細表示
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

  # 商品詳細の編集
  def edit
    if user_signed_in? && current_user.id == @item.user_id_id
      @grandchild = Category.find(@item[:category_id])
      @child = @grandchild.parent
      @parent = @child.parent
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

      @bland = Bland.pluck(:name, :id)
    
    elsif user_signed_in?
      redirect_to(root_path)
    else
      redirect_to(user_session_path)
    end
  end

  # 商品詳細の編集アップデート
  def update
    if @item.update!(item_params)
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
    if @item.destroy
      redirect_to(root_path)
    else
      redirect_to action: :edit, notice: "削除できません"
    end

  end

  # 商品出品
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

  # 子カテゴリー
  def category_children
    children = Category.find(params[:name]).name
    @category_children = Category.find_by(name: children, ancestry: nil ).children
  end

  # 孫カテゴリー
  def category_grandchildren
    @category_grandchildren = Category.find(params[:child_id]).children
  end

  # デリバリーカテゴリー
  def delivery_children
    delivery = Delivery.find(params[:name]).name
    @delivery_children = Delivery.find_by(name: delivery, ancestry: nil).children
  end

  # 商品の出品
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '出品完了しました！'
    else
      flash.now[:alert] = "必須項目を埋めてください。"
      render :new
    end
  end

  # 商品の購入
  require 'payjp'
  def buy
    @item = Item.find(params[:format])
    @card = Card.find_by(user_id: current_user.id)
    @user = User.find(id= current_user.id)
    if @card.blank?
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"] 
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  def done
    @card = Card.find_by(user_id: current_user.id)
    @item = Item.find(params[:format])
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
    @item.update(buyer_id: current_user.id)
    end
  end

  # ログイン状態の確認
  def confirmation  #ログインしていない場合ははユーザー登録に移動
    unless user_signed_in?
      redirect_to(user_session_path)
    end
  end

  # データベースへの保存
  private
    def item_params
      params.require(:item).permit(:product_name,
                                  :product_text,
                                  :price,
                                  :image, 
                                  :category_id,
                                  :bland_id, 
                                  :size, 
                                  :delivery_id, 
                                  :shipping_region, 
                                  :shipping_date, 
                                  :commodity_condition, 
                                  :seller_id, 
                                  :buyer_id).merge(user_id_id: current_user.id, seller_id: current_user.id)
    end
  

end
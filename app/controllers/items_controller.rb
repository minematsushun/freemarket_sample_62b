class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :show, :destroy, :buy, :done]
  before_action :confirmation, only: [:new]
  before_action :move_to_index , except: [:index ,:show]

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
    @user = User.find(@item[:seller_id])
    @box = Item.order("RAND()").limit(6)
    @grandchild = Category.find(@item[:category_id])
    @child = @grandchild.parent
    @parent = @child.parent
    @bland = Bland.find(@item[:bland_id])
    @delivery = Delivery.find(@item[:delivery_id])
    @charge = @delivery.parent
    @address = Prefecture.find(@item[:shipping_region])
  end

  # 商品詳細の編集
  def edit
    if user_signed_in? && current_user.id == @item.user_id_id

    @category_parent_array = Category.roots
    @category_child_array = @item.category.parent.parent.children
    @category_grandchild_array = @item.category.parent.children

    @delivery_parent_array = Delivery.roots
    @delivery_child_array = @item.delivery.parent.children

    @bland = Bland.pluck(:name, :id)

    elsif user_signed_in?
      redirect_to(root_path)
    else
      redirect_to(user_session_path)
    end
  end

  # 商品詳細の編集アップデート
  def update
    if @item.update(item_params)
      redirect_to(items_path)
    else
      redirect_to action: :edit, notice: "全項目入力できていません"
    end

  end


  def destroy
    if user_signed_in? && current_user.id == @item.seller_id
      if @item.destroy
        redirect_to(root_path)
      else
        redirect_to action: :edit, notice: "削除できません"
      end
    else
      redirect_to root_path
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
      render new, alert: '必須項目を埋めてください。'
    end
  end

  # 商品の購入
  require 'payjp'
  def buy
    @card = current_user.cards.first
    @address = Prefecture.find(current_user.address_prefecture)
      if user_signed_in?
        if current_user.id != @item.seller_id
          if @item.buyer_id
            redirect_to root_path
          else
            unless @card.blank?
            Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
            customer = Payjp::Customer.retrieve(@card.customer_id)
            @default_card_information = customer.cards.retrieve(@card.card_id)
          end
        end
      else
        redirect_to root_path
      end
    else
      redirect_to user_session_path
    end
  end

  def done

    @card = current_user.cards.first
    @address = Prefecture.find(current_user.address_prefecture)
    if @card.blank?
      redirect_to controller: "card", action: "new"
    else
      Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
      Payjp::Charge.create(
        amount:   @item.price,
        customer: @card.customer_id,
        currency: 'jpy',
      )
      if @item.update(buyer_id: current_user.id)
      else
        redirect_to root_path
      end
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
  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def set_item
    @item = Item.find(params[:id])
  end

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
class Item < ApplicationRecord

  belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id', optional: true
  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id', optional: true
  # belongs_to :user, optional: true
  belongs_to :category
  belongs_to :delivery
  belongs_to :bland
  # belongs_to :item, optional: true
  
  mount_uploader :image, ImageUploader

  # validates :name, presence: true, length: { maximum: 40 }
  # validates :description, presence: true, length: { maximum: 1000 }
  # validates :category_id, presence: true
  # validates :condition, presence: true
  # validates :shipping_fee, presence: true
  # validates :shipping_method, presence: true
  # validates :prefecture_id, presence: true
  # validates :shipping_date, presence: true
  # validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  # validates :seller_id, presence: true
  # validates :status,  presence: true

end

class Item < ApplicationRecord

  belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id', optional: true
  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id', optional: true
  # belongs_to :user, optional: true
  belongs_to :category
  belongs_to :delivery
  belongs_to :bland
  # belongs_to :item, optional: true
  
  mount_uploader :image, ImageUploader

end

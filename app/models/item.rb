class Item < ApplicationRecord

  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User"
  belongs_to :category
  belongs_to :delivery
  belongs_to :bland
  belongs_to :item, optional: true
  mount_uploader :image, ImageUploader

end

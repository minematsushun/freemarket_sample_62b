class Item < ApplicationRecord

  # belongs_to :seller, class_name: "user"
  # belongs_to :buyer, class_name: "user"
  belongs_to :category
  belongs_to :delivery
  belongs_to :bland
  belongs_to :item, optional: true

end

class Delivery < ApplicationRecord
  has_many :items
  has_ancestry
end

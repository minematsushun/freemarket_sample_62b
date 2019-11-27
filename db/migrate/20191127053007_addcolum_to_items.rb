class AddcolumToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :size, :string, null: false
    add_column :items, :commodity_condition, :string, null: false
    add_reference :items, :delivery, foreign_key: true
    add_column :items, :shipping_region, :string, null: false
    add_column :items, :shipping_date, :string, null: false
    add_column :items, :seller_id, :integer
    add_column :items, :buyer_id, :integer
  end
end

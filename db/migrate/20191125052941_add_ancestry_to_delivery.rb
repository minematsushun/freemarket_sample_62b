class AddAncestryToDelivery < ActiveRecord::Migration[5.2]
  def change
    add_column :deliveries, :ancestry, :string
    add_index :deliveries, :ancestry
  end
end

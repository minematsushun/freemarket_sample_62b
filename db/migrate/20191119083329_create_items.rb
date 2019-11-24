class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|

      t.string      :product_name, null: false
      t.string      :product_text, null: false
      t.integer     :price, null: false
      t.references  :user_id

      t.timestamps
    end
  end
end

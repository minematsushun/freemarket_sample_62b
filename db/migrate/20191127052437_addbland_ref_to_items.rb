class AddblandRefToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :bland, foreign_key: true
  end
end

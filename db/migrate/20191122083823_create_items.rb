class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string              :productname,
      t.integer
      t.timestamps
    end
  end
end

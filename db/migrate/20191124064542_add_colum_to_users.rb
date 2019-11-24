class AddColumToUsers < ActiveRecord::Migration[5.2]
  def change
      #step1
      add_column :users, :nickname,                 :string, null: false
      add_column :users, :last_name,                :string, null: false
      add_column :users, :first_name,               :string, null: false
      add_column :users, :last_name_kana,           :string, null: false
      add_column :users, :first_name_kana,          :string, null: false
      add_column :users, :birthday_year,            :integer, null: false
      add_column :users, :birthday_month,           :integer, null: false
      add_column :users, :birthday_day,             :integer, null: false
      #step2
      add_column :users, :phone_number,             :integer, null: false, unique: true
      #step3
      add_column :users, :address_last_name,        :string, null: false
      add_column :users, :address_first_name,       :string, null: false
      add_column :users, :address_last_name_kana,   :string, null: false
      add_column :users, :address_first_name_kana,  :string, null: false
      add_column :users, :post_code,                :string, null: false
      add_column :users, :address_prefecture,       :string, null: false, default: 0
      add_column :users, :address_city,             :string, null: false
      add_column :users, :address_number,           :string, null: false
      add_column :users, :address_building,         :string
      add_column :users, :address_phone_number,     :integer
      #other
      add_column :users, :introduce,                :text
  end
end

# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|String|null: false|
|email|String|null: false|
|reset_password_token|String|
|nickname|String|null: false|
|last_name|String|null: false|
|first_name|String|null: false|
|last_name_kana|String|null: false|
|first_name_kana|String|null: false|
|birthday_year|integer|null: false|
|birthday_month|integer|null: false|
|birthday_day|integer|null: false|
|phone_number|integer|null: false|
|address_last_name|String|null: false|
|address_first_name|String|null: false|
|address_last_name_kana|String|null: false|
|address_first_name_kana|String|null: false|
|post_code|String|null: false|
|address_prefecture|String|null: false|
|address_city|String|null: false|
|address_number|String|null: false|
|address_building|String|
|address_phone_number|integer|
|introduce|text|

### Association
- has_many :cards
- has_many :items
- has_many :sns_credentials, dependent: :destroy
- has_many :seller_items, class_name: 'Item', foreign_key: 'seller_id'
- has_many :buyer_items, class_name: 'Item', foreign_key: 'buyer_id'

## sns_credentialsテーブル
|Column|Type|Options|
|------|----|-------|
|provider|String|
|uid|String|
|user_id|references|foreign_key: true|

### Association
- blongs_to : user

### cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false|
|customer_id|integer|null: false|
|card_id|integer|null: false|

### Association
- blongs_to : user

### itemsテーブル
|Column|Type|Options|
|------|----|-------|
|product_name|String|null: false|
|product_text|String|null: false|
|price|integer|null: false|
|user_id|references|null: false, foreign_key: true|
|image|text|null: false|
|category_id|references|null: false, foreign_key: true|
|bland_id|references|null: false, foreign_key: true|
|size|String|null: false|
|commodity_condition|String|null: false|
|delivery_id|references|null: false, foreign_key: true|
|shipping_region|String|null: false|
|shipping_date|String|null: false|
|seller_id|references|class_name: "user"|
|buyer_id|references|class_name: "user"|

### Association
- belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id', optional: true
- belongs_to :seller, class_name: 'User', foreign_key: 'seller_id', optional: true
- belongs_to :category
- belongs_to :delivery
- belongs_to :bland

### categorysテーブル
|Column|Type|Options|
|------|----|-------|
|categorys_id|references|null: false, foreign_key: true|
|name|String|null: false, unique: true|

### Association
- has_many :items
- has_ancestry

### blandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|String|null: false|

### Association
- has_many :items

### deliveriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|String|null: false|

### Association
- has_many :items
- has_ancestry

### addressesテーブル
|Column|Type|Options|
|------|----|-------|
|prefecture_id|integer|
|city|String|

### Association
- belongs_to_active_hash :prefecture
- delegate :name, to: :prefecture
<!--  -->
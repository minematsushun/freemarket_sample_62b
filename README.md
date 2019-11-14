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

## Usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|String|null: false|
|email|String|null: false|
|password|String|null: false|
|family_name|String|null: false|
|last_name|String|null: false|
|kana_family_name|String|null: false|
|kana_last_name|String|null: false|
|comment|text|null: false|
|year|integer|null: false|
|month|integer|null: false|
|day|integer|null: false|

### Association
has_many :buyer_items, class_name: 'Item', foreign_key: 'buyer_id'
has_many :seller_items, class_name: 'Item', foreign_key: 'seller_id'
has_many :comments, dependent: :destroy
has_many :goods, dependent: :destroy
has_many :user_address
has_many :user_pays 

## user_addressテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|reference|null: false, foreign_key: true|
|postalcode|String|null: false|
|prefectures|String|null: false|
|city|String|null: false|
|street|String|null: false|
|apartment_name|String|null: false|
|phone_number|String|null: false|

### Association
blongs_to : user

### user_paysテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|reference|null: false, foreign_key: true|
|credit_id|integer|null: false|
|customer_id|integer|null: false|


### Association
blongs_to : user

### itemsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|image_id|references|null: false, foreign_key: true|
|product_name|String|null: false|
|product_text|String|null: false|
|category_id|references|null: false, foreign_key: true|
|bland_id|references|null: false, foreign_key: true|
|size_id|references|null: false, foreign_key: true|
|commodity_condition|String|null: false|
|shipping_fee|String|null: false|
|shipping_region|String|null: false|
|shipping_date|String|null: false|
|price|String|null: false|
|seller_id|references|class_name: "User"|
|buyer_id|references|class_name: "User"|

### Association
belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id'
belongs_to :seller, class_name: 'User', foreign_key: 'seller_id'
has_many: images
has_many: comments, dependent: :destroy
has_many: likes, dependent: :destroy


### imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image_id|references|null: false, foreign_key: true|
|image_url|String|null: false|

### Association
belongs_to: item


### categorysテーブル
|Column|Type|Options|
|------|----|-------|
|categorys_id|references|null: false, foreign_key: true|
|category|String|null: false, unique: true|

### Association
has_many: items


### brandsテーブル
|Column|Type|Options|
|------|----|-------|
|bland_id|references|null: false, foreign_key: true|
|brand|String|null: false|

### Association
has_many: items


### sizesテーブル
|Column|Type|Options|
|------|----|-------|
|size_id|references|null: false, foreign_key: true|
|size|string|null: false|

### Association
belongs_to: item


### goodsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|
|good|string|null: false|

#### Association
belongs_to: user
belongs_to: item


### commentsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|
|comment|text|null: false|

#### Association
belongs_to: user
belongs_to: item


### Users_profileテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|nickname|String|null: false|
|text|String|
|avatar|String|

#### Association
belongs_to: user
belongs_to: item
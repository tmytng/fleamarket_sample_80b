# README

# db設計

## userテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false, unique: true|
|email|string|null: false,unique: true|
|encrypted_password|string|null: false|
|user_image|string|
|introduction|text| 
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string    null: false|
|first_name_kana|string null: false|
|birth_day|date|null: false|

### Association
- has_many :products dependent: :destroy        
- belongs_to :delivery_destination dependent: :destroy      
- belongs_to :card dependent: :destroy      

## delivery_destinationテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kane|string|null: false|
|post_code|integer(7)|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|address|string|null: false|
|building_name|string|  
|phone_number|integer|null: false|

### Association
- belongs_to :user      

## delivery_destinationテーブル

|Column|Type|Options|
|------|----|-------|
|card_number|integer|null:false, unique: true|
|expiration_year|integer|null:false|
|expiration_month|integer|null:false|
|security_code|integer|null:false|
|user_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user  

## productテーブルテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|price|string|null: false|
|description|string|null: false|
|condition|string|null: false|
|size|string|null: false|
|shipping_cost|string|null: false|
|shipping_days|string|null: false|
|prefecture_id|string|null: false|
|trading_status|enum|null: false|
|category_id|integer|null: false, foreign_key: true|
|brand_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user

## product_imgテーブル

|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|product_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :product

## categoryテーブル

|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|product_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :product

## brandテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- belongs_to :product

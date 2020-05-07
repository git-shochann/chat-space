# Chat-Space DB設計!!!

## usersテーブル!
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|email|string|null: false|
|password|string|null: false|
### アソシエーション
- has_many :chats
- has_many :groups_users
- has_many :groups, through: :groups_users



## groupsテーブル!
|Column|Type|Options|
|------|----|-------|
|title|string|null :false|
### アソシエーション
- has_many :chats
- has_many :groups_users
- has_many :users, through: :groups_users



## chatsテーブル!
|Column|Type|Options|
|------|----|-------|
|text|text||
|photo|text||
user_id|string|null: false, foreign: true|
group_id|string|null: false, foreign: true|
### アソシエーション
- belongs_to: user
- belongs_to: group



## groups_usersテーブル!
|Column|Type|Options|
|------|----|-------|
|user_id|string|null: false, foreign: true|
|group_id|string|null: false, foreign: true|
### アソシエーション
- belongs_to :user
- belongs_to :group
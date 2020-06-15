# Chat-Space DB設計!!!

<!-- 作成済み -->
## usersテーブル!
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|email|string|null: false|
|password|string|null: false|
### アソシエーション
- has_many :messages
- has_many :group_users
- has_many :groups, through: :group_users


<!-- 6/7 titleカラムをnameカラムへ変更 -->
## groupsテーブル!
|Column|Type|Options|
|------|----|-------|
|name|string|null :false|
### アソシエーション
- has_many :messages
- has_many :group_users
- has_many :users, through: :group_users

<!-- 6/12 chatsテーブルをmessagesテーブルに変更.textカラムをscontentカラムへ,photoカラムをimagaカラムへ,text型からstring型へ -->
## messagesテーブル!
|Column|Type|Options|
|------|----|-------|
|content|string||
|photo|string||
user_id|string|null: false, foreign: true|
group_id|string|null: false, foreign: true|
### アソシエーション
- belongs_to: user
- belongs_to: group


 <!-- 中間テーブル(作成中) -->
## group_usersテーブル!
|Column|Type|Options|
|------|----|-------|
|group_id|references|null: false, foreign: true|
|user_id|references|null: false, foreign: true|
### アソシエーション
- belongs_to :user
- belongs_to :group


<!-- MEMO -->
<!-- 44,45 => string型ではない。ここは外部キーであり、数字なのでintegerもしくはforeign:true(外部キー制約),references型にした方が良い。 -->

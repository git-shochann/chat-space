# ChatApp

## 使用技術

- Ruby, Rails, MySQL

## DB 設計

### users

| Column   | Type   | Options         |
| -------- | ------ | --------------- |
| name     | string | null: falsaaaaa |
| email    | string | null: false     |
| password | string | null: false     |

- has_many :messages
- has_many :group_users
- has_many :groups, through: :group_users

### groups

| Column | Type   | Options     |
| ------ | ------ | ----------- |
| name   | string | null :false |

- has_many :messages
- has_many :group_users
- has_many :users, through: :group_users

### messages

| Column   | Type   | Options                    |
| -------- | ------ | -------------------------- |
| content  | string |                            |
| photo    | string |                            |
| user_id  | string | null: false, foreign: true |
| group_id | string | null: false, foreign: true |

- belongs_to: user
- belongs_to: group

### group_users

| Column   | Type       | Options                    |
| -------- | ---------- | -------------------------- |
| group_id | references | null: false, foreign: true |
| user_id  | references | null: false, foreign: true |

- belongs_to :user
- belongs_to :group

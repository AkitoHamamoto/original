# テーブル

## users テーブル

| Column             | Type    | Option      |
| ------------------ | ------- | ----------- |
| nickname           | string  | null: false |
| email              | string  | null: false |
| encrypted_password | string  | null: false |
| birth_date         | date    | null: false |
| authority          | boolean | null: false |

### Association

- has_many :room_users
- has_many :rooms, through: room_users
- has_many :messages
- has_many :posts

## rooms テーブル

| Column | Type   | Option       |
| ------ | ------ | ------------ |
| name   | string | null:false   |

### Association

- has_many :room_users
- has_many :users, through: room_users
- has_many :messages

## room_users テーブル

| Column | Type       | Option                        |
| ------ | ---------- | ----------------------------- |
| user   | references | null:false, foreign_key: true |
| room   | references | null:false, foreign_key: true |

### Association

- belongs_to :room
- belongs_to :user

### messages テーブル

| Column  | Type       | Option                        |
| ------- | ---------- | ----------------------------- |
| content | string     |                               |
| user    | references | null:false, foreign_key: true |
| room    | references | null:false, foreign_key: true |

### Association

- belong_to :room
- belong_to :user

### posts テーブル

| Column | Type       | Option                        |
| ------ | ---------- | ----------------------------- |
| number | integer    | null:false                    |
| title  | string     | null:false                    |
| text   | string     | null:false                    |
| mark   | boolean    | null:false                    |
| user   | references | null:false, foreign_key: true |

### Association

- belong_to :user

### boards テーブル

| Column | Type   | Option       |
| ------ | ------ | ------------ |
| text   | string | null:false   |

### plans テーブル

| Column | Type   | Option       |
| ------ | ------ | ------------ |
| text   | string | null:false   |

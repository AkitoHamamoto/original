# アプリケーション名: ManuaList

## アプリケーション概要
- このアプリケーションはアルバイトの指導マニュアル動画を管理できるアプリケーションです。

## URL
[heroku](https://original-32086.herokuapp.com/)

## 利用方法
- MANUALページに遷移していただき"投稿する"というリンクから動画の投稿ができます。

## <details><summary>目指した課題解決</summary>
飲食店向けにアルバイトのマニュアルを管理するアプリです。このアプリを使うことで、アルバイトが入れ替わるたびに同じ説明を繰り替えす
必要も、アルバイトの方も忙しい中、わからない箇所を質問し、仕事をしながらメモをとると言った作業を一切なくすことができます。また、
店にいなくても自宅にいながら予習、復習ができるということでとても効率的です。
</details>

## 洗い出した要件
- 機能: 動画投稿(編集)(削除)機能
  - 目的:  マニュアル動画を一覧としてユーザーが閲覧できるようにする。
  - 詳細:  マニュアル動画、説明文、checkマーク、サムネイルも付けられるようにして動画を管理しやすくする。

- 機能: 動画検索機能
  - 目的: マニュアル動画を検索できるようにする。
  - 詳細: タイトル名で検索ができるようにする。

- 機能: 掲示板投稿機能
  - 目的: その日の連絡を投稿できるようにする。
  - 詳細:  テキストの投稿、削除ができる。

- 機能: 予定投稿機能
  - 目的: 今後の予定を投稿できるようにする。
  - 詳細: テキストの投稿、削除ができる。

- 機能: 店舗情報投稿機能
  - 目的: 店舗の情報を掲載する。
  - 詳細: 店舗情報を投稿、編集できる。

- 機能: 店舗位置情報表示機能
  - 目的: 登録した店舗の位置情報を検索、表示する機能。
  - 詳細: GoogleMapのAPIを利用して実装する。


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

- has_many :posts
- has_many :boards
- has_many :plans


### posts テーブル

| Column | Type       | Option                        |
| ------ | ---------- | ----------------------------- |
| number | integer    | null:false                    |
| title  | string     | null:false                    |
| text   | text       | null:false                    |
| mark   | boolean    | null:false                    |
| user   | references | null:false, foreign_key: true |

### Association

- belongs_to :user

### boards テーブル

| Column | Type   | Option       |
| ------ | ------ | ------------ |
| text   | string | null:false   |

- belongs_to :user

### plans テーブル

| Column | Type   | Option       |
| ------ | ------ | ------------ |
| text   | string | null:false   |

- belongs_to :user

### shops テーブル

| Column       | Type    | Option       |
| ------------ | ------- | ------------ |
| name         | string  | null:false   |
| postal_code  | integer | null:false   |
| address      | string  | null:false   |
| phone_number | string  | null:false   |
| text         | text    | null:false   |

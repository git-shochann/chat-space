Rails.application.routes.draw do

  devise_for :users
  root to: 'groups#index'
  resources :users, only: [:index, :edit, :update]
  resources :groups, only: [:new, :create, :edit, :update] do
    resources :messages, only: [:index, :create]
  end

end



## MEMO ##

# indexアクションカリキュラムだと2回記載。
# ルーティングのネストに関して
# 7行目のnewアクションは必要なし => 新規投稿のリクエストに対するアクションであって、.newは新規インスタンス作成。

# メッセージ送信機能の実装に必要なルーティング↓↓↓
# 投稿されたメッセージの一覧表示&メッセージの入力ができる:index
# メッセージの保存を行う:create
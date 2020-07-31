Rails.application.routes.draw do

  devise_for :users
  root to: 'groups#index'
  resources :users, only: [:index, :edit, :update]
  resources :groups, only: [:new, :create, :edit, :update] do
    resources :messages, only: [:index, :create]
    namespace :api do
      resources :messages, only: :index, default: { format: 'json' }
    end
  end

end



## MEMO ##

# indexアクションカリキュラムだと2回記載。
# ルーティングのネストに関して
# 7行目のnewアクションは必要なし => 新規投稿のリクエストに対するアクションであって、.newは新規インスタンス作成。

# メッセージ送信機能の実装に必要なルーティング↓↓↓
# 投稿されたメッセージの一覧表示&メッセージの入力ができる:index
# メッセージの保存を行う:create

# namespaceを使ったコントローラを仕様している場合、ルーティングの書き方が少し異なる。
# namespace :ディレクトリ名 do ~ end
# 9行目 => defaultsオプションを利用して、このルーティングが来たらjson形式でレスポンスするよう指定 
#         結果的に、jbuilderいくのにdefaultオプションを書く必要は、誤作動を起こさないようにする為。

# ルーティングをネストさせる理由
# パスが変わる ,　取れるparamsが変わる！
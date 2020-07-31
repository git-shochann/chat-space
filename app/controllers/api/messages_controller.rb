class Api::MessagesController < ApplicationController
  
  def index
      # ルーティングでの設定でparamsの中にgroup_idというキーでグループのidが入るので、これを元にDBからグループを取得する！
    group = Group.find(params[:group_id])
      # ajax(jsファイル側)で送られてくる最後のメッセージのid番号を変数に代入。
    last_message_id = params[:id].to_i
      # ?にlast_message_idが入る。?を使うときにはwhere(カラム名: "条件")のような書き方は出来ない。
    @messages = group.messages.includes(:user).where("id > ?", last_message_id)
      # 取得したグループでのメッセージから、idがlast_message_idよりも新しい(大きい)メッセージ達のみを取得
  end

end


# 1,今表示されているメッセージよりも新しい投稿があるのか確認する機能を追加(新規投稿を確認するアクションを作成！)
# 2,上記のアクションを呼び出す仕組みがあること

# 新規で投稿されたメッセージのみをDBから取得する処理のみ記載。
# ビューに表示されている最新メッセージのidが送られてくる（後ほど実装）為、そのidより新しい投稿があるかをチェック.

# - 最終的にデータベースにある出力されていない最新のメッセージを取得したい！
# - 6行目 => どこのグループかの情報は必要
# - 7行目 => 最後のメッセージのID
# - 8行目 => 最後のメッセージのIDとDBのIDと比べて大きかったら@messagesに入れる。

# 自動更新のイベント発火は何秒かに一回。

# エラーで悩んだ。大文字や大文字のスペースでエラー注意。
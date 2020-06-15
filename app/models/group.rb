class Group < ApplicationRecord

has_many :group_users
has_many :users, through: :group_users
has_many :messages

validates :name, presence: true, uniqueness: true

def show_last_message
  if ( message = messages.last ).present?
    if message.content?
      message.content
    else
      "画像が投稿されています！"
    end
  else "まだメッセージはありません！"
  end
end


end


# MEMO

# 構造 メッセージが投稿されている場合、されていない場合で処理を分けている.
# 続き メッセージが投稿されている場合の内部で、さらに文章が投稿されている場合、画像が投稿されている場合で処理を分けている.
# lastメソッド => 配列の要素を取り出すときその配列の中の最後の要素(レコード)を取得メソッド
# 10行目 messages.last => グループが持っているメッセージ複数の配列を取り出して? グループの指定は?
#  => メソッドであり呼び出されるのを待っている.ビューで先にグループの情報がセットされている.
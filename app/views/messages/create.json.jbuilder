# binding.pry
# appendしたい内容は,フォームにて入力した内容！
# 名前,日付,内容(文字),内容(画像)
# json.キー名 バリュー
# strftime("書式") 日時データを、指定したフォーマットで文字列に変換することができるメソッド

json.user_name @message.user.name
json.created_at @message.created_at.strftime("%Y年%m月%d日 %H時%M分")
json.content @message.content
json.image @message.image_url

# imageに関してはbinding.pryでも分かる通り、image_urlまでしないといけない。
# jsファイル側では、キー名を指定する！
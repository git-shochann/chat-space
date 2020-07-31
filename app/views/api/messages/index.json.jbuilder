
# リクエスト(自動更新)が発生するとbinding.pryが出来る。JSファイルをまだ書いてないので出来ない。
# binding.pryは普通に出来る。なぜ出来ないかは、jbuilderファイルを読み込んでなかった為。

json.array! @messages do |message|
  json.content message.content
  json.image message.image.url
  json.created_at message.created_at.strftime("%Y年%m月%d日 %H時%M分")
  json.user_name message.user.name
  json.id message.id
  
  
end



# ""複数情報を持ってくるとき""配列化して持ってくる為jsonを作成するときも一個一個処理しなくてはならない。
# 必要なものをビューやHTMLを考えてjbuilderで返したいデータを作成。
# 例 (pictweet)

# 0:
# id: 1
# image: "https://cdn.snkrdunk.com/uploads/media/20200622094632-8.jpeg"
# nickname: "taro"
# text: "Air Dior"
# user_id: 1 
# user_sign_in: {id: 1, email: "hello@test.com", created_at: "2020-07-07T05:39:01.000Z", updated_at: "2020-07-07T05:39:01.000Z", nickname: "taro"}

# 1:
# id:2
# image : "https://cdn.snkrdunk.com/uploads/media/20200622034232-8.jpeg"
# nickname: "sho"
# text: "hello"
# user_id: 2

# 上記のような形で持ってくる為。それぞれ一旦binding.pryした方が分かりやすい。
# キーの名前は何でもOK。
# jbuilderを作成するときやっぱり、非同期で出したいHTMLを出したいものを元にして何が必要か逆算していく！
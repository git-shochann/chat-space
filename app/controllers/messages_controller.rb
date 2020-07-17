class MessagesController < ApplicationController

  before_action :set_group
  
  def index   # 一覧表示にて必要なのは新規投稿と全てのメッセージを表示.
    @message = Message.new   # 新しいメッセージを追加したいのでメッセージモデルの新規のインスタンスを生成し,フォームの中に入っていく.(id,content,image,group_id,user_id,created_at,update_at)
    @messages = @group.messages.includes(:user)   # @messagesはグループが持つ全ての投稿の情報を含むもの.この@messagesは後ほどメッセージの画面の実装で必要.
    # @groupが持っている複数のmessages(has_manyの為複数形),アソシエーションを組んでいる為この表記が可。includes(関連名)
  end

  ### Ajax実装前 ###
  # def create   #リソースを新規作成して追加(保存)する
  #   message = @group.messages.new(message_params)   # 保存先を指定,ここで引数にmessage_paramsとする事で,保存するものを指定する.
  #   if message.save   # 条件分岐をする為に2行に分ける.(もしメッセージが保存出来たのならば)
  #     redirect_to group_messages_path(@group), notice: 'メッセージを送信出来ました!'   # @groupの中には該当するIDの一つのグループを持ってきてる事を念頭に置く、
  #   else
  #     @messages = @group.messages.includes(:user)   # renderで戻る時に元の情報を表示しておく為.
  #     flash.now[:alert] = 'メッセージを入力して下さい'
  #     render :index
  #   end
  # end

  def create 
    @message = @group.messages.new(message_params) #ビューに持っていく為、インスタンス変数。
    if @message.save  #DBに保存できたら
      respond_to do |format|
        format.json
      end
    else
      @messages = @group.messages.includes(:user)  #保存されなかった時は、全ての投稿情報を出す為。index.html.erbのビューに持ってく@messages
      flash.now[:alert] = 'メッセージを入力してください'
      render :index #index.html.erb
    end
  end

 private
 
  def set_group
    # binding.pryを使って、そのURIパターンにアクセスされた時に、どのような情報がparamsの箱に入っているか確認する!!!
    # 上記の結果==> {"controller"=>"messages", "action"=>"index", "group_id"=>"1"} permitted: false>なので、キー名は:idではない。
    @group = Group.find(params[:group_id])
    # グループを選択をしてからメッセージを送るので,グループ情報を先に取得しておく.ルーティングネストにより,生成されるパスは/groups/:group_id/messagesというURIパターン
    # before_actionではその@groupが複数のアクションで登場する為!修正が面倒.
    # リクエストにて発生したidをparamsのキーとしてレコード１行分を取って、@groupに代入.
    # @groupは1つの情報が入っているので単数形に.
  end

  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end

end
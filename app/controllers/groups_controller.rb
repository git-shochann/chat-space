class GroupsController < ApplicationController


  def index
    # binding.pryしてみる!!!
  end
  
  def new
    @group = Group.new
    @group.users << current_user
  end

  def create
    if Group.create(group_params)
      redirect_to root_path, notice: 'グループを作成しました'
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    # binding.pry
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_messages_path(@group), notice: 'グループを更新しました'
    else
      render :edit
    end
  end

  private
   def group_params
    params.require(:group).permit(:name, user_ids: [])
    # (:groupとはgroupモデル(groupテーブル)を指定している)
    # []ってなんだっけ？

   end

end


# 36行目でparamsメソッドで取り出すものを決めてその返り値を保存する!

# グループの更新の際、パラメーターがしっかりと送れているかの結果。以下現在チャットメンバーにログインしているユーザーのみが入っている。
#<ActionController::Parameters {"utf8"=>"✓", "_method"=>"patch", "authenticity_token"=>"XrUnPwaWnNRpNb/vVrHmsxRAcM47Xc0/pcuX8ADjW0ap77MRu4Hl/S5daulZKxsm+vs9A5gQnqg1CLBezS06sw==", 
#### "group"=>{"name"=>"Group-1", "user_ids"=>["2"]}, #### ここが重要！
#"commit"=>"更新する", "controller"=>"groups", "action"=>"update", "id"=>"1"} permitted: false>

# MEMO #
# [1] pry(#<GroupsController>)> params  # ここではまだ発生したパラメーターの中身全部である。
# => <ActionController::Parameters {"utf8"=>"✓", "_method"=>"patch", "authenticity_token"=>"eC+djpO4ei0y/TK/byNzbmqBKcnNzXe/aSwPXsrzlzGPdQmgLq8DBHWV57lguY77hDpkBG6AJCj57yjwBz32xA==", "group"=>{"name"=>"Group-1", "user_ids"=>["2", "1"]}, "commit"=>"更新する", "controller"=>"groups", "action"=>"update", "id"=>"1"} permitted: false>
# [2] pry(#<GroupsController>)> group_params
# => <ActionController::Parameters {"name"=>"Group-1", "user_ids"=>["2", "1"]} permitted: true>
# [3] pry(#<GroupsController>)> 
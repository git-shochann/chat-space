class UsersController < ApplicationController

# usersのindexアクションに書いたけど、なんでもok

  def index
    if params[:keyword] == ""
      return nil
    else
      @users = User.where('name LIKE (?)', "%#{params[:keyword]}%" ).where.not(id: current_user.id).limit(10)   # @usersには入力したキーワードと一致するレコードを取得する記述をする！
      respond_to do |format|
        format.html
        format.json
      end
    end
  end


  def edit   # edit.html.erbへ移動
  end

  def update

    if current_user.update(user_params)   # 現在のログインしているユーザーをupdateする！
      redirect_to root_path
    else
      render :edit
    end

  end 

  private

  def user_params
  params.require(:user).permit(:name, :email)
  end

end


## MEMO ##

# redirect_toとrenderの違いに関しては"GoodNote Chat-Space Rails (Lesson9)に詳細あり。


### カリキュラムの回答の別解に関して -users_controller.rb- ###

#  def index
#   @users = User.search(params[:keyword], current_user.id) # Userモデルに対してのsearch(引数)メソッド
#     respond_to do |format|
#       format.html
#       format.json
#     end
#   end

### カリキュラムの別解回答に関して -user.rb- ###

# def self.search(input, id)  # 実引数からもらったinputとidを使って取得するものを決める。
#   return nil if input == ""
#   User.where(['name LIKE ?', "%#{input}%"] ).where.not(id: id).limit(10)
# end

# 仕様を必ず確認すること、where.not(条件)で現在のユーザーのレコードは持ってこない事をしている。
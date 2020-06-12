class UsersController < ApplicationController

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
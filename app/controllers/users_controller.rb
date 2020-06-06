class UsersController < ApplicationController

  def edit   # edit.html.erbへ移動
  end

  def update

    if current_user.update(user_params)   # 現在のログインしているユーザーをupdateする！
      redirect_to root_path   # トップページへ戻る
    else
      render :edit  # ??? であれば9行目は:indexでは？
    end

  end

  private

  def user_params
  params.require(:user).permit(:name, :email)
  end

end
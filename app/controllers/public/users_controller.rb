class Public::UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "登録情報が更新されました。"
      redirect_to public_user_path(current_user)
    else
      render 'edit'
    end
  end
  
  def unsubscribe
    @user = current_user
  end
  
  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行しました。"
    redirect_to root_path
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end  
  
end

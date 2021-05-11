class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update,:destroy]

  def show
    @user = User.find(params[:id])
    @comics = @user.comics.page(params[:page]).per(8).order("updated_at DESC")
  end

  def edit
  end

  def index
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice:"ユーザ情報を更新しました"
    else
      @comics = @user.comics.page(params[:page]).per(8)
      render :show
    end
  end

  def destroy
    @user.destroy
    redirect_to user_session
  end

  private

  def user_params
    params.require(:user).permit(:name,:email)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(@user.id)
    end
  end

end

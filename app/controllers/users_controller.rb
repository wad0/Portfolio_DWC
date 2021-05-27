class UsersController < ApplicationController
  before_action :ensure_correct_user, only: %i[update destroy keeps]

  def show
    @user = User.find(params[:id])
    @comics = @user.comics.page(params[:page]).order('updated_at DESC')
    @all_tags = ActsAsTaggableOn::Tag.all.most_used(20)
    @tags = @comics.tag_counts_on(:tags)
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: 'ユーザ情報を更新しました'
    else
      @comics = @user.comics.page(params[:page])
      render :show
    end
  end

  def destroy
    @user.destroy
    redirect_to user_session
  end

  def keeps
    @keep_comics = User.find(params[:id]).keep_comics.page(params[:page])
    @all_tags = ActsAsTaggableOn::Tag.all.most_used(20)
    @tags = @keep_comics.tag_counts_on(:tags)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    redirect_to user_path(@user.id) unless @user == current_user
  end
end

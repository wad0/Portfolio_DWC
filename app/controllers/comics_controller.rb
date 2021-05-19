class ComicsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :ensure_correct_user, only: [:create,:edit, :update, :destroy]

  def new
    @comic = Comic.new
  end

  def create
    @comic = Comic.new(comic_params)
    @comic.user_id = current_user.id
    if @comic.save
      redirect_to user_path(current_user.id), notice:"記録を保存しました"
    else
      render :new
    end
  end

  def index
    @comics = Comic.all.page(params[:page]).per(8).order("updated_at DESC")
    @keep = Keep.new
  end

  def edit
    @comic = Comic.find(params[:id])
  end

  def update
    if @comic.update(comic_params)
      redirect_to user_path(current_user.id), notice:"記録を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @comic.destroy
    redirect_to comics_path, notice:"記録を削除しました"
  end

  private

  def comic_params
    params.require(:comic).permit(:title,:memo,:complete,:evaluation)
  end

  def ensure_correct_user
    @comic = Comic.find(params[:id])
    unless @comic.user == current_user
      redirect_to comics_path
    end
  end

end

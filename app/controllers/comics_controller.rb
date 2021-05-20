class ComicsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @comic = Comic.new
    @all_tags = ActsAsTaggableOn::Tag.all
  end

  def create
    @comic = Comic.new(comic_params)
    @comic.user_id = current_user.id
    if @comic.save
      redirect_to user_path(current_user.id), notice:"記録を保存しました"
    else
      @all_tags = ActsAsTaggableOn::Tag.all
      render :new
    end
  end

  def index
    @keep = Keep.new
    @all_tags = ActsAsTaggableOn::Tag.all
    @tags = Comic.tag_counts_on(:tags)
    if params[:tag]
      @comics = Comic.tagged_with(params[:tag])
    else
      @comics = Comic.all.page(params[:page]).per(8).order("updated_at DESC")
    end
  end

  def edit
    @comic = Comic.find(params[:id])
    @all_tags = ActsAsTaggableOn::Tag.all
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
    params.require(:comic).permit(:title,:memo,:complete,:evaluation, tag_list: [])
  end

  def ensure_correct_user
    @comic = Comic.find(params[:id])
    unless @comic.user == current_user
      redirect_to comics_path
    end
  end

end

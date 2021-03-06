class ComicsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show search sort]
  before_action :ensure_currect_user, only: %i[edit update destroy]

  def new
    @comic = Comic.new
    @all_tags = ActsAsTaggableOn::Tag.all.most_used(20)
  end

  def create
    @comic = Comic.new(comic_params)
    @comic.user_id = current_user.id
    if @comic.save
      redirect_to comics_path, notice: '投稿を保存しました'
    else
      @all_tags = ActsAsTaggableOn::Tag.all.most_used(20)
      render :new
    end
  end

  def index
    @keep = Keep.new
    @all_tags = ActsAsTaggableOn::Tag.all.most_used(20)
    @comics = if params[:tag]
                Comic.tagged_with(params[:tag]).page(params[:page]).order('updated_at DESC')
              else
                Comic.all.page(params[:page]).order('updated_at DESC')
              end
  end

  def edit
    @comic = Comic.find(params[:id])
    @all_tags = ActsAsTaggableOn::Tag.all.most_used(20)
  end

  def update
    if @comic.update(comic_params)
      redirect_to comics_path, notice: '投稿を更新しました'
    else
      @all_tags = ActsAsTaggableOn::Tag.all.most_used(20)
      render :edit
    end
  end

  def destroy
    @comic.destroy
    redirect_to comics_path, notice: '投稿を削除しました'
  end

  def search
    @all_tags = ActsAsTaggableOn::Tag.all.most_used(20)
    @comics = Comic.search(params[:search]).page(params[:page]).order('updated_at DESC')
  end

  def sort
    @all_tags = ActsAsTaggableOn::Tag.all.most_used(20)
    @comics = Comic.sort(params[:sort]).page(params[:page])
  end

  private

  def comic_params
    params.require(:comic).permit(:title, :memo, :complete, :evaluation, tag_list: [])
  end

  def ensure_currect_user
    @comic = Comic.find(params[:id])
    redirect_to comics_path unless @comic.user == current_user
  end
end

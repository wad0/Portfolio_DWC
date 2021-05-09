class ComicsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @comic = Comic.new
  end

  def create
    @comic = Comic.new(comic_params)
    @comic.save
    redirect_to comics_path
  end

  def index
    @comics = Comic.all.page(params[:page]).per(8)
  end

  def show
    @comic = Comic.find(params[:id])
  end

  def edit
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

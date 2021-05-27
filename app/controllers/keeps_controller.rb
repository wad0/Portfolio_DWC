class KeepsController < ApplicationController
  def create
    # @keep = current_user.keeps.new(comic_id: params[:comic_id])
    # @keep.save
    # flash[:notice] = "読みたいリストに追加しました"
    # redirect_back(fallback_location: root_path)
    @comic = Comic.find(params[:comic_id])
    keep = @comic.keeps.new(user_id: current_user.id)
    keep.save
  end

  def destroy
    # @keep = Keep.find_by(comic_id: params[:comic_id], user_id: current_user.id)
    # @keep.destroy
    # flash[:notice] = "読みたいリストから削除しました"
    # redirect_back(fallback_location: root_path)
    @comic = Comic.find(params[:comic_id])
    keep = @comic.keeps.find_by(user_id: current_user.id)
    keep.destroy
  end
end

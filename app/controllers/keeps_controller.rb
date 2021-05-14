class KeepsController < ApplicationController

  def create
    @keep = current_user.keeps.new(comic_id: params[:comic_id])
    @keep.save
    redirect_to comics_path, notice:"読みたいリストに追加しました"
  end

  def destroy
    @keep = Keep.find_by(comic_id: params[:comic_id], user_id: current_user.id)
    @keep.destroy
    redirect_to comics_path, notice:"読みたいリストから削除しました"
  end

end

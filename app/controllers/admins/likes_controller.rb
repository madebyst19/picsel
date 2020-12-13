class Admins::LikesController < ApplicationController
  def index

    @user = User.where(id: admin.id)
    @likes = Like.where(user_id: admin.id)
  end
  def create
      @like = current_user.likes.create(photo_id: params[:photo_id])

      redirect_back(fallback_location: root_path)
  end

    def destroy
      @like = Like.find_by(photo_id: params[:photo_id], user_id: admin.id)
      @like.destroy
      redirect_back(fallback_location: root_path)
    end
    private
    def photo_params
      params.require(:photo).permit(:photo)

    end
end
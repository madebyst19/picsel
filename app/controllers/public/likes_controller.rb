class Public::LikesController < ApplicationController
    before_action :authenticate_user!
    def index
      @user = User.where(id: current_user.id)
      @likes = Like.where(user_id: current_user.id)
    end
    def create
        @like = current_user.likes.create(photo_id: params[:photo_id])

        redirect_back(fallback_location: root_path)
    end

      def destroy
        @like = Like.find_by(photo_id: params[:photo_id], user_id: current_user.id)
        @like.destroy
        redirect_back(fallback_location: root_path)
      end
      private
      def photo_params
        params.require(:photo).permit(:photo)

      end
end

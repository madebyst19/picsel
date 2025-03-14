class Public::RelationshipsController < ApplicationController
  before_action :set_search
    def create
        @user = User.find(params[:relationship][:following_id])
        current_user.follow!(@user)
        redirect_to public_photos_path(@user)
      end
      def destroy
        @user = User.find(params[:id])
        current_user.unfollow!(@user)
        redirect_to public_photos_path(@user)
      end
end

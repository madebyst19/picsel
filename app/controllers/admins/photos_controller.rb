class Admins::PhotosController < ApplicationController
  def top
    @photos = Photo.all
  end
  def index
    @user = User.find(params[:user_id])
    @photos = Photo.where(user_id: @user.id)
  end
  def edit
    @photo = Photo.find(params[:id])
    @user = User.find_by(id: @photo.user_id)

  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update(photo_params)
        redirect_to admins_photo_path(@photo)
      else
        render
      end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
   redirect_to top_admins_photospath
end

  def show
    @photo = Photo.find(params[:id])
    @user = User.find_by(id: @photo.user)
    @like = Like.new
  end
  def photo_params
    params.require(:photo).permit(:title, :gallary_id , :image, :caption, :price,:hashbody, :is_active, hashtag_ids:[])
end
end

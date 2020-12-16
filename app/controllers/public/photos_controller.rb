class Public::PhotosController < ApplicationController
    before_action :authenticate_user!
    def index
        @tag_list = Tag.all  
        if params[:user_id].nil?
            @user = current_user
        else
            @user = User.find(params[:user_id])
        end
        @photos = Photo.where(user_id: @user.id)
        @hashtag = Hashtag.find_by(hashname: params[:tag])
        @hashtag_photos = @hashtag.photos if @hashtag.present?
    end
    def new
        @photo = Photo.new
        @gallaries = Gallary.all
        @tag_list = Tag.all 
    end
    def create
        @photo = current_user.photos.new(photo_params)
        if photo_params[:is_active] == '有効'
            @photo.is_active = true
        elsif photo_params[:is_active] == '無効'
            @photo.is_active = false
        end
        if @photo.save
            redirect_to public_photo_path(@photo.id)
        else
            render new_public_photo_path
        end
    end
    def show
        @photo = Photo.find(params[:id])
        @cart_item = CartItem.new
        @user = User.find_by(id: @photo.user_id)
        @like = Like.new
    end
    def edit
        @photo = Photo.find(params[:id])
        @user = User.find_by(id: @photo.user_id)
    end
    def update
        @photo = Photo.find(params[:id])
        if @photo.update(photo_params)
            redirect_to public_photo_path(@photo)
        else
            render "index"
        end
    end
    def destroy
        @photo = Photo.find(params[:id])
        @photo.destroy
       redirect_to public_photos_path
    end
    def hashtag
        @hashname =  params[:hashname_cont]
        @hashtags = Hashtag.where(['hashname LIKE ?', "%#{params[:hashname_cont]}%"])
        hashtag_photo_ids = []
        @hashtags.each do |hashtag|
            hashtag.hashtag_photos.each do |hashtag_photo|
                hashtag_photo_ids << hashtag_photo.id
            end
        end
        if @hashname == ""
            @hashtag_photos =  []
            @hashtag_photos_count = 0
        else
            @hashtag_photos = HashtagPhoto.where(id: hashtag_photo_ids.uniq)
            @hashtag_photos_count = @hashtag_photos.count
        end
      end
      def search
        @Photoss = Photo.search(params[:search])
      end
    private
    def photo_params
        params.require(:photo).permit(:title, :gallary_id , :image, :caption, :price,:hashbody, :is_active, hashtag_ids:[])
    end
end

class PhotosController < ApplicationController
  def index
    @photos = Photo.all
    render json: @photos
  end

  def show
    @photo = Photo.find(params[:id])
    render json: @photo
  end

  def create
    # Find the Portfolio by portfolio_id
    @portfolio = Portfolio.find(params[:portfolio_id])

    # Create a new Photo associated with the found Portfolio
    @photo = @portfolio.photos.new(photo_params.except(:portfolio_id))

    if @photo.save
      render json: @photo, status: :created
    else
      render json: @photo.errors, status: :unprocessable_entity
    end
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update(photo_params)
      render json: @photo
    else
      render json: @photo.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    head :no_content
  end

  private

  def photo_params
    params.require(:photo).permit(:title, :description, :portfolio_id, :article_id, :user_id, :image)
  end
end

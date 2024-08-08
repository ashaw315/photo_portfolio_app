class VideosController < ApplicationController
    def index
    @videos = Video.all
    render json: @videos
  end

  def show
    @video = Video.find(params[:id])
    render json: @video
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      render json: @video, status: :created
    else
      render json: @video.errors, status: :unprocessable_entity
    end
  end

  def update
    @video = Video.find(params[:id])
    if @video.update(video_params)
      render json: @video
    else
      render json: @video.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy
    head :no_content
  end

  private

  def video_params
    params.require(:video).permit(:title, :description, :video_url, :user_id, :video_file)
  end
end

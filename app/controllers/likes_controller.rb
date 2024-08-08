class LikesController < ApplicationController
    def index
    @likes = Like.all
    render json: @likes
  end

  def show
    @like = Like.find(params[:id])
    render json: @like
  end

  def create
    @like = Like.new(like_params)
    if @like.save
      render json: @like, status: :created
    else
      render json: @like.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    head :no_content
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :likeable_id, :likeable_type)
  end
end

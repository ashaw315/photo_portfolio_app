class ArticlesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
    def index
        @articles = Article.all
        render json: @articles
      end
    
      def show
        @article = Article.find(params[:id])
        render json: @article
      end
    
      def create
        @article = Article.new(article_params)
        if @article.save
          render json: @article, status: :created
        else
          render json: @article.errors, status: :unprocessable_entity
        end
      end
    
      def update
        @article = Article.find(params[:id])
        if @article.update(article_params)
          render json: @article
        else
          render json: @article.errors, status: :unprocessable_entity
        end
      end
    
      def destroy
        @article = Article.find(params[:id])
        @article.destroy
        head :no_content
      end
    
      private
    
      def article_params
        params.require(:article).permit(:title, :content, :user_id, :portfolio_id)
      end

      def record_not_found
        render json: { error: 'Record not found' }, status: :not_found
      end
end

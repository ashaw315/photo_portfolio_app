class PortfoliosController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def index
    @portfolios = Portfolio.all
    render json: @portfolios
  end

  def show
    @portfolio = Portfolio.find(params[:id])
    render json: @portfolio
  end

  def create
    @portfolio = Portfolio.new(portfolio_params)
    if @portfolio.save
      render json: @portfolio, status: :created
    else
      render json: @portfolio.errors, status: :unprocessable_entity
    end
  end

  def update
    @portfolio = Portfolio.find(params[:id])
    if @portfolio.update(portfolio_params)
      render json: @portfolio
    else
      render json: @portfolio.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @portfolio = Portfolio.find(params[:id])
    @portfolio.destroy
    head :no_content
  end

  private

  def portfolio_params
    params.require(:portfolio).permit(:title, :description, :user_id)
  end

  def record_not_found
    render json: { error: 'Record not found' }, status: :not_found
  end
end

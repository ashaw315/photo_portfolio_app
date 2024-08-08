class RecordsController < ApplicationController
    def index
    @records = Record.all
    render json: @records
  end

  def show
    @record = Record.find(params[:id])
    render json: @record
  end

  def create
    @record = Record.new(record_params)
    if @record.save
      render json: @record, status: :created
    else
      render json: @record.errors, status: :unprocessable_entity
    end
  end

  def update
    @record = Record.find(params[:id])
    if @record.update(record_params)
      render json: @record
    else
      render json: @record.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @record = Record.find(params[:id])
    @record.destroy
    head :no_content
  end

  private

  def record_params
    params.require(:record).permit(:content, :user_id, :photo_id, :video_id)
  end
end

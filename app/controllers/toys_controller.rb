class ToysController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
  wrap_parameters format: []

  def index
    toys = Toy.all
    render json: toys
  end

  def create
    toy = Toy.create!(toy_params)
    render json: toy, status: :created
  end

  def update
    toy = find_toy
    toy.update!(toy_params)
    render json: toy
  end

  def destroy
    toy = find_toy
    toy.destroy
    head :no_content
  end

  private

  def render_unprocessable_entity invalid
    render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
  end
  
  def toy_params
    params.permit(:name, :image, :likes, :id)
  end

  def find_toy
    Toy.find_by(id: params[:id])
  end

end

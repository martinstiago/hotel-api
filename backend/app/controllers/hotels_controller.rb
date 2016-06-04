class HotelsController < ApplicationController
  before_action :find_hotel, except: [:index, :create]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @hotels = params[:search].present? ? Hotel.fuzzy_search(params[:search]) : Hotel.all
    render json: @hotels
  end

  def create
    @hotel = Hotel.new(hotel_params)
    if @hotel.save
      render json: @hotel, status: :created
    else
      render json: @hotel.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @hotel
  end

  def update
    if @hotel.update_attributes(hotel_params)
      head :no_content, status: :ok
    else
      render json: @hotel.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @hotel.destroy
      head :no_content, status: :ok
    else
      render json: @hotel.errors, status: :unprocessable_entity
    end
  end

  private

  def hotel_params
    params.require(:hotel)
          .permit(:name, :address, :star_rating, :accomodation_type_id)
  end

  def find_hotel
    @hotel = Hotel.find(params[:id])
  end

  def record_not_found(error)
    render json: { error: error.message }, status: :not_found
  end
end

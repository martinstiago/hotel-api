class HotelsController < ApplicationController
  before_filter :find_hotel, except: [:index, :create]

  def index
    render json: Hotel.all
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
end

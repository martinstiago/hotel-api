class AccomodationTypesController < ApplicationController
  def index
    render json: AccomodationType.all
  end

  def show
    @ac = AccomodationType.find(params[:id])
    render json: @ac
  end
end

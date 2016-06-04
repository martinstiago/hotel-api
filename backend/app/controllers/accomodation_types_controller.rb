class AccomodationTypesController < ApplicationController
  def index
    render json: AccomodationType.all
  end
end

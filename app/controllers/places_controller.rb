class PlacesController < ApplicationController

  skip_before_filter :ensure_that_signed_in

  def index
  end

  def show
    @place = BeermappingApi.place_location(params[:id])
    if @place.empty?
      redirect_to places_path, notice: "Location couldn't be found"
    else
      render :show
    end
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end
end
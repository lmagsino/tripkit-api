class Api::V1::ItineraryItemsController < ApplicationController
  include Authenticable

  before_action :set_trip
  before_action :set_itinerary_item, only: [:show, :update, :destroy]

  # GET /api/v1/trips/:trip_id/itinerary_items
  def index
    @itinerary_items = @trip.itinerary_items.ordered
    render json: @itinerary_items
  end

  # GET /api/v1/trips/:trip_id/itinerary_items/:id
  def show
    render json: @itinerary_item
  end

  # POST /api/v1/trips/:trip_id/itinerary_items
  def create
    @itinerary_item = @trip.itinerary_items.build(itinerary_item_params)
    @itinerary_item.created_by_user = current_user

    if @itinerary_item.save
      render json: @itinerary_item, status: :created
    else
      render json: { errors: @itinerary_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/trips/:trip_id/itinerary_items/:id
  def update
    if @itinerary_item.update(itinerary_item_params)
      render json: @itinerary_item
    else
      render json: { errors: @itinerary_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/trips/:trip_id/itinerary_items/:id
  def destroy
    @itinerary_item.destroy
    head :no_content
  end

  private

  def set_trip
    @trip = current_user.trips.find(params[:trip_id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ['Trip not found'] }, status: :not_found
  end

  def set_itinerary_item
    @itinerary_item = @trip.itinerary_items.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ['Itinerary item not found'] }, status: :not_found
  end

  def itinerary_item_params
    params.require(:itinerary_item).permit(:date, :time, :title, :location, :notes, :category)
  end
end
class Api::V1::TripsController < ApplicationController
  include Authenticable

  before_action :set_trip, only: [:show, :update, :destroy]

  # GET /api/v1/trips
  def index
    @trips = current_user.trips.order(start_date: :desc)
    render json: @trips
  end

  # GET /api/v1/trips/:id
  def show
    render json: @trip, include: [:users, :expenses, :itinerary_items]
  end

  # POST /api/v1/trips
  def create
    @trip = current_user.created_trips.build(trip_params)

    if @trip.save
      render json: @trip, status: :created
    else
      render json: { errors: @trip.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/trips/:id
  def update
    if @trip.update(trip_params)
      render json: @trip
    else
      render json: { errors: @trip.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/trips/:id
  def destroy
    @trip.destroy
    head :no_content
  end

  # POST /api/v1/trips/join
  def join
    trip = Trip.find_by(invite_code: params[:invite_code])

    if trip.nil?
      render json: { errors: ['Invalid invite code'] }, status: :not_found
      return
    end

    membership = trip.trip_memberships.find_or_initialize_by(user: current_user)

    if membership.persisted?
      render json: { message: 'Already a member of this trip', trip: trip }, status: :ok
    elsif membership.save
      render json: { message: 'Successfully joined trip', trip: trip }, status: :created
    else
      render json: { errors: membership.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_trip
    @trip = current_user.trips.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ['Trip not found'] }, status: :not_found
  end

  def trip_params
    params.require(:trip).permit(:name, :start_date, :end_date, :base_currency, :active_currency, :total_budget)
  end
end
class Api::V1::DocumentsController < ApplicationController
  include Authenticable

  before_action :set_trip
  before_action :set_document, only: [:show, :destroy]

  # GET /api/v1/trips/:trip_id/documents
  def index
    @documents = @trip.documents.order(uploaded_at: :desc)
    render json: @documents
  end

  # GET /api/v1/trips/:trip_id/documents/:id
  def show
    render json: @document
  end

  # POST /api/v1/trips/:trip_id/documents
  def create
    @document = @trip.documents.build(document_params)
    @document.uploaded_by_user = current_user

    if @document.save
      render json: @document, status: :created
    else
      render json: { errors: @document.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/trips/:trip_id/documents/:id
  def destroy
    @document.destroy
    head :no_content
  end

  private

  def set_trip
    @trip = current_user.trips.find(params[:trip_id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ['Trip not found'] }, status: :not_found
  end

  def set_document
    @document = @trip.documents.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ['Document not found'] }, status: :not_found
  end

  def document_params
    params.require(:document).permit(:title, :document_type, :notes, :file)
  end
end
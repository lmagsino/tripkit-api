class Api::V1::ExpensesController < ApplicationController
  include Authenticable

  before_action :set_trip
  before_action :set_expense, only: [:show, :update, :destroy]

  # GET /api/v1/trips/:trip_id/expenses
  def index
    @expenses = @trip.expenses.includes(:paid_by_user, :expense_splits).order(expense_date: :desc)
    render json: @expenses, include: [:paid_by_user, :expense_splits]
  end

  # GET /api/v1/trips/:trip_id/expenses/:id
  def show
    render json: @expense, include: [:paid_by_user, :expense_splits, :split_users]
  end

  # POST /api/v1/trips/:trip_id/expenses
  def create
    @expense = @trip.expenses.build(expense_params)
    @expense.paid_by_user = current_user

    if @expense.save
      create_expense_splits
      render json: @expense, status: :created
    else
      render json: { errors: @expense.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/trips/:trip_id/expenses/:id
  def update
    if @expense.update(expense_params)
      render json: @expense
    else
      render json: { errors: @expense.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/trips/:trip_id/expenses/:id
  def destroy
    @expense.destroy
    head :no_content
  end

  private

  def set_trip
    @trip = current_user.trips.find(params[:trip_id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ['Trip not found'] }, status: :not_found
  end

  def set_expense
    @expense = @trip.expenses.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ['Expense not found'] }, status: :not_found
  end

  def expense_params
    params.require(:expense).permit(:amount, :currency, :category, :description, :split_type, :expense_date)
  end

  def create_expense_splits
    split_users = params[:split_user_ids] || @trip.user_ids
    guest_names = params[:guest_names] || []

    if @expense.split_type == 'equal'
      total_splits = split_users.count + guest_names.count
      share_amount = @expense.amount / total_splits

      # Create splits for registered users
      split_users.each do |user_id|
        @expense.expense_splits.create(user_id: user_id, share_amount: share_amount)
      end

      # Create splits for guest users
      guest_names.each do |guest_name|
        @expense.expense_splits.create(guest_name: guest_name, share_amount: share_amount)
      end
    elsif @expense.split_type == 'custom' && params[:custom_splits].present?
      params[:custom_splits].each do |split|
        if split[:user_id].present?
          @expense.expense_splits.create(user_id: split[:user_id], share_amount: split[:share_amount])
        elsif split[:guest_name].present?
          @expense.expense_splits.create(guest_name: split[:guest_name], share_amount: split[:share_amount])
        end
      end
    end
  end
end
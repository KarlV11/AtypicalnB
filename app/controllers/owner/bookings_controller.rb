class Owner::BookingsController < ApplicationController
  before_action :check_owner_mode
  before_action :set_booking, only: [:accept, :refuse]

  def index
    @bookings = Booking.where(user_id: current_user.id)
  end

  def accept
    @booking.accepted = true
    if @booking.save
      redirect_to owner_bookings_path
    else
      # Add error alert
      flash[:alert] = "Failed to accept booking."
    end
  end

  def refuse
    @booking.accepted = false
    if @booking.save
      redirect_to owner_bookings_path
    else
      # Add error alert
      flash[:alert] = "Failed to refuse booking."
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def check_owner_mode
    unless current_user.owner_mode
      redirect_to root_path
    end
  end
end

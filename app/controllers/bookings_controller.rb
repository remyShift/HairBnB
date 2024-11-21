class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    redirect_to user_path
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def destroy
    @booking.destroy
  end

  private

  def booking_params
    params.require(:booking).permit(
                                :start_time,
                                :end_time
                              )
  end
end

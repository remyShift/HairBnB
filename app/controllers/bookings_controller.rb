class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)

    Rails.logger.debug("Booking Params: #{params.inspect}")

    @booking.user = current_user

    @booking.save!
      redirect_to user_path(current_user), notice: 'Booking successfully created!'
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
                                :end_time,
                                :wig_id,
                                :user_id
                              )
  end
end

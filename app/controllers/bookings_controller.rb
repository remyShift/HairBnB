class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def new
    @booking = Booking.new
  end

  def create
    start_time = booking_params[:start_time].first(10)
    end_time = booking_params[:start_time].last(10)
    @wig = Wig.find(params[:wig_id])
    @booking = Booking.new()
    @booking.start_time = start_time
    @booking.end_time = end_time
    @booking.user = current_user
    @booking.wig = @wig

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

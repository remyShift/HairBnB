class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    @wigs = current_user.wigs
    @bookings = current_user.bookings
  end

  private

  def set_user
    @user = current_user
    @bookings = []
    @wigs =[]
  end

  def destroy
    resource.destroy
    redirect_to root_path, notice: "Your account has been successfully deleted."
  end
end

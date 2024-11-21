class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    @wigs = current_user.wigs
  end

  private

  def set_user
    @user = current_user
    @bookings = []
    @wigs =[]
  end
end

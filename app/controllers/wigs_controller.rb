class WigsController < ApplicationController
  before_action :set_wig, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:create]
  def index


    if params.present?
      location = params[:location] if params[:location].present?
      product = params[:product] if params[:product].present?
    end

    if location && product
      sql_subquery = <<~SQL
      (name ILIKE :product
      OR color ILIKE :product
      OR length ILIKE :product
      OR material ILIKE :product
      OR hair_style ILIKE :product
      OR users.first_name ILIKE :product
      OR users.last_name ILIKE :product)
      AND address ILIKE :location
      SQL
      # sql_subquery = "address ILIKE :address AND name ILIKE :product"
      @wigs = Wig.joins(:user).where(sql_subquery, location: "%#{location}%", product: "%#{product}%" )
    elsif location
      sql_subquery = "address ILIKE :location"
      @wigs = Wig.where(sql_subquery, location: "%#{location}%")
    elsif product
      sql_subquery = <<~SQL
      name ILIKE :product
      OR color ILIKE :product
      OR length ILIKE :product
      OR material ILIKE :product
      OR hair_style ILIKE :product
      OR users.first_name ILIKE :product
      OR users.last_name ILIKE :product
      SQL
      @wigs = Wig.joins(:user).where(sql_subquery, product: "%#{product}%")
    else
      @wigs = Wig.all
    end

    @markers = @wigs.geocoded.map do |wig|
      {
        lat: wig.latitude,
        lng: wig.longitude
      }
    end
  end

  def show
    @booking = Booking.new
    @wig = Wig.find(params[:id])
    @markers = [{
        lat: @wig.latitude,
        lng: @wig.longitude
      }]
  end

  def new
    @wig = Wig.new
  end

  def create
    @wig = Wig.new(wig_params)
    @wig.user = @user
    if @wig.save
      redirect_to wig_path(@wig)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @wig.update(wig_params)
      redirect_to wig_path(@wig)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @wig.destroy
    redirect_to wigs_path
  end

  private

  def set_wig
    @wig = Wig.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def wig_params
    params.require(:wig).permit(
                                :name,
                                :material,
                                :color,
                                :hair_style,
                                :length,
                                :address,
                                :price,
                                :wig_image,
                                :latitude,
                                :longitude,
                                :user_id
                              )
  end
end

class WigsController < ApplicationController
  before_action :set_wig, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:create]
  def index
    puts "-----------------------------------"
    puts "params: #{params}"
    puts "-----------------------------------"

    if params[:search].present?
      location = params[:search][:location].downcase if params[:search][:location].present?
      product = params[:search][:product].downcase if params[:search][:product].present?
    end

    if location && product
      @wigs = Wig.where("lower(address) LIKE ?", "%#{location}%").where("lower(name) LIKE ?", "%#{product}%")
    elsif location
      @wigs = Wig.where("lower(address) LIKE ?", "%#{location}%")
    elsif product
      @wigs = Wig.where("lower(name) LIKE ?", "%#{product}%")
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

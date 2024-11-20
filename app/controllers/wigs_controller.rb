class WigsController < ApplicationController
  before_action :set_wig, only: [:show, :edit, :update, :destroy]
  def index
    location = params[:location].downcase if params[:location]
    product = params[:product].downcase if params[:product]
    if params[:location].present? && params[:product].present?
      @wigs = Wig.where("lower(address) LIKE ?", "%" + location + "%").where("lower(name) LIKE ?", "%" + product + "%")
    elsif params[:location].present?
      @wigs = Wig.where("lower(address) LIKE ?", "%" + location + "%")
    elsif params[:product].present?
      @wigs = Wig.where("lower(name) LIKE ?", "%" + product + "%")
    else
      @wigs = Wig.all
    end

    respond_to do |format|
      format.html
      format.json # Follows the classic Rails flow and look for a create.json view
    end
  end

  def show
    @wig = Wig.find(params[:id])
  end

  def new
    @wig = Wig.new
  end

  def create
    @wig = Wig.new(wig_params)
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

  def wig_params
    params.require(:wig).permit(
                                :name,
                                :material,
                                :color,
                                :hair_style,
                                :length,
                                :address,
                                :price,
                                :wig_image
                              )
  end
end

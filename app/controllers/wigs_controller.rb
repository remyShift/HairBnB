class WigsController < ApplicationController
  before_action :set_wig, only: [:show]
  def index
    @wigs = Wig.all
  end

  def show
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
                                :image
                              )
  end
end

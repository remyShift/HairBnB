class WigsController < ApplicationController
  def index
    Wig.all
  end
end

class ApplicationController < ActionController::Base
  before_action :set_ressource

  protected

  def set_ressource
    @resource = User.new
    @resource_name = :user
  end
end

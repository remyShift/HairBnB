# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate(auth_options)
    if resource
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      self.resource = User.new(sign_in_params)
      flash.now[:alert] = "Invalid email or password."
      @show_modal_login = true
      respond_to do |format|
        format.html { render "shared/form-login", status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("modalLogin", partial: "shared/form-login", locals: { resource: resource }) }
      end
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end

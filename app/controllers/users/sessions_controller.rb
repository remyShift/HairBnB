# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end
  def show
    @user = current_user
  end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate(auth_options)
    if resource
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("overlay", partial: "shared/modal", locals: { resource: resource }),
            turbo_stream.replace("navbar", partial: "shared/navbar", locals: { resource: resource })
          ]
        end
      end
    else
      self.resource = User.new(sign_in_params)
      flash.now[:alert] = "Invalid email or password."
      @show_modal_login = true
      respond_to do |format|
        format.html { render "shared/form-login", status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("modalLogin", partial: "shared/modal-login", locals: { resource: resource }) }
      end
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :password, :password_confirmation])
  # end
end

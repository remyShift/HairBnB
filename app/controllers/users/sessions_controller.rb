# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    # Remplacez build_resource par User.new ou le modèle approprié
    resource = User.new(sign_in_params)
    
    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_in
        sign_in(resource_name, resource)
        respond_with resource, location: after_sign_in_path_for(resource)
      else
        set_flash_message! :notice, :"signed_in_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_in_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
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

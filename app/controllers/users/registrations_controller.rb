class Users::RegistrationsController < Devise::RegistrationsController
  # Over ride the devie function for users and send them to root path after sign up
  def after_sign_up_path_for(resource)
    root_path
  end


  # Add permitted parameters for Devise
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Permit additional parameters for sign-up and account update overwrite devise
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone_number, :address, :city, :country])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone_number, :address, :city, :country])
  end
end

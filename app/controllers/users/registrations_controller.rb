class Users::RegistrationsController < Devise::RegistrationsController
  # Over ride the devie function for users and send them to root path after sign up
  def after_sign_up_path_for(resource)
    root_path
  end
end

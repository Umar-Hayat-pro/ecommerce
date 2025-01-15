class Users::SessionsController < Devise::SessionsController
  # Over ride the devie function for users and send them to root path after sign in
  def after_sign_in_path_for(resource)
    root_path
  end
end

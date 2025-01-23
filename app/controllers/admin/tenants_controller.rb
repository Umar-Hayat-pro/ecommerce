class Admin::TenantsController < AdminController
  def index
    @tenants = User.with_role
  end
end
